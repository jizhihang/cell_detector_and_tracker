function [M, hypTypes] = generateHypothesisMatrix(tracklets, options)
	% GENERATEHYPOTHESISMATRIX generates a matrix with probablities that each tracklet might be an initializer, terminator, linker, false positive.
	% For each tracklets it computes the following hypothesis:
	% 	- initialization
	% 	- termination
	% 	- link with each of the following tracklets
	% 	- false positive
	% Inputs:
	% 	tracklets = a tracklets matrix generated by the generateTracklets() function
	% 	options = a struct containing any of:
	% 		maxGap = [20] maximum gap between tracks that may be closed
	% Outputs:
	% 	M = a sparse row matrix containing a row for each tracklet hypotesis. The dimensions of this matrix are numHypothesis x (2*nTracklets)
	%   hypTypes = a vector indicating which type of hypothesis it is:
	% 	1 = init
	% 	2 = term
	% 	3 = false posive
	% 	4 = link
	%------------------------------------------------------------------Options
	if nargin < 2; options = struct; end

	TYPE_INIT = 1;
	TYPE_TERM = 2;
	TYPE_FP = 3;
	TYPE_LINK = 4;

	% Defaults
	maxGap = 20;
	MAX_DISPLACEMENT_LINK = 513; % a very large number, larger than the image size

	% Overrides
	if isfield(options, 'maxGap')
		maxGap = options.maxGap;
	end

	if isfield(options, 'MAX_DISPLACEMENT_LINK')
		MAX_DISPLACEMENT_LINK = options.MAX_DISPLACEMENT_LINK;
	end
	%--------------------------------------------------------Preallocate space

	numTracklets = size(tracklets, 1);

	% To know the total number of hypothesis, I need to know the number of link
	% hypothesis for each tracklet. I need to find out the number of tracklets
	% starting in the following maxGap frames after the last cell in the
	% tracklet

	trackletsBinary = min(1, tracklets);
	kernel = [1 -1]; % detect starts/ends of tracklets
	Itracklets = conv2(trackletsBinary, kernel);
	% Careful! 
	% There seemed to be a bug if I run the updateTracklets command several times
	% with increasing maxGap, which results from the fact that merged tracks
	% can have discontinuities, thus tracks could link to themselves in the future
	% or a discontinued track could link to a third track twice. It is fixed here below:
	[iI, iJ] = find(Itracklets==1); % Initializations
	[tI, tJ] = find(Itracklets==-1); % Terminations

	% Take only the first initialization and last termination of each tracklet
	[iI, idx] = unique(iI);
	iJ = iJ(idx);

	[tI, idx] = unique(tI, 'last');
	tJ = tJ(idx);

	% This is a reduction by like 1-2 orders of magniture

	% Dataset 2:
	% total hypos: 4823
	% link hypos: 4316
	% then helimintated: 3971
	% new link hypos: 2953


	% Dataset 3:
	% total hypos:  122402
	% link hypos: 118820
	% new link hypos:  8360


	% Dataset 4:
	% total hypos: 226916
	% link hypos: 218339
	% new link hypos: 6213


	% Dataset 5:
	% total hypos: 33738
	% link hypos: 31707
	% new link hypos: 2601

	linkHypothesis = getLinkHypothesis(iI, iJ, tI, tJ, maxGap, MAX_DISPLACEMENT_LINK);
	numLinkHypothesis = full(sum(sum(linkHypothesis)));
	fprintf('\tThere are %d link hypohtesis.\n', numLinkHypothesis)

	numHypothesis = numLinkHypothesis + 3 * numTracklets; % init, term, fp

	hypTypes = zeros(numHypothesis, 1);

	% The hypothesis matrix requires:
	% 	- 1 entry for each initialization hypothesis
	% 	- 1 entry for each termination hypothesis
	% 	- 2 entries for each false positive hypothesis
	% 	- 2 entries for each link hypothesis
	I = zeros(numTracklets * 4 + 2 * numLinkHypothesis, 1); 
	J = zeros(numTracklets * 4 + 2 * numLinkHypothesis, 1);
	S = ones(numTracklets * 4 + 2 * numLinkHypothesis, 1);
	%-------------------------------------------------------Compute hypothesis

	hyphCumIdx = 0;
	probCumIdx = 0;
	% Compute initialization hypothesis
	hypTypes(1:numTracklets) = TYPE_INIT;
	for i=1:numTracklets
		I(i) = i; % 
		J(i) = numTracklets + i; % tracklet idx in second part of matrix
	end
	hyphCumIdx = hyphCumIdx + numTracklets;
	probCumIdx = probCumIdx + numTracklets;

	% Compute termination hypothesis
	hypTypes(hyphCumIdx+1:hyphCumIdx+numTracklets) = TYPE_TERM;
	for i=1:numTracklets
		I(hyphCumIdx + i) = hyphCumIdx + i;
		J(hyphCumIdx + i) = i;
	end
	hyphCumIdx = hyphCumIdx + numTracklets;
	probCumIdx = probCumIdx + numTracklets;

	% Compute false positive hypothesis
	hypTypes(hyphCumIdx+1:hyphCumIdx+numTracklets) = TYPE_FP;
	for i=1:numTracklets
		I(hyphCumIdx + i) = i + hyphCumIdx;
		I(hyphCumIdx + numTracklets + i) = i + hyphCumIdx;
		J(hyphCumIdx + i) = i;
		J(hyphCumIdx + numTracklets + i) = i + numTracklets;
	end
	hyphCumIdx = hyphCumIdx + numTracklets*2;
	probCumIdx = probCumIdx + numTracklets;

	% Compute link hypothesis
	[ilink, jlink] = find(linkHypothesis);
	% [size(ilink, 1) numLinkHypothesis]

	hypTypes(probCumIdx+1:probCumIdx+numLinkHypothesis) = TYPE_LINK;
	% TODO: I think I could vectorize this below
	for i=1:numLinkHypothesis
		I(hyphCumIdx + i) = i + probCumIdx;
		I(hyphCumIdx + numLinkHypothesis + i) = i + probCumIdx;
		J(hyphCumIdx + i) = ilink(i);
		J(hyphCumIdx + numLinkHypothesis + i) = jlink(i) + numTracklets;
	end

	M = sparse(I, J, S);
end

function H = getLinkHypothesis(initializationY, initializationX, terminationY, terminationX, maxGap, MAX_DISPLACEMENT_LINK)
	% GETLINKHYPOTHESIS return a sparse matrix of dimensions nTracklets x nTracklets with 1 indicating tracks that can be linked
	% Inputs:
	% 	initializationY = y coordinates of all tracklets beginnings/heads
	% 	initializationX = x coordinates of all tracklets beginnings/heads
	% 	terminationY = y coordinates of all tracklet ends/tails
	% 	terminationX = x coordinates of all tracklet ends/tails
	% 	maxGap = the maximum number of frames ahead to look for poss possible linking tracklets
	% Outputs:
	% 	H = a sparse row matrix contaitning for each tracklet the indices of possible continuing tracklets.

	global DSOUT;

	numTracklets = numel(initializationX);

	% This is to prevent excessive dynamic reallocation of space
	optimisticEstimateOfLinksPerTracklets = 4;
		
	I = zeros(numTracklets*optimisticEstimateOfLinksPerTracklets, 1);
	J = zeros(numTracklets*optimisticEstimateOfLinksPerTracklets, 1);

	numLinkHypothesis = 1;
	for i=1:numTracklets
		% For each tracklet end, find the number of tracklet starting in the next
		% maxGap frames
		% Only consider trcklets that are not too far apart to improve speed
		xEndA = terminationX(i);
		yEndA = terminationY(i);

		xStartBInd = (initializationX >= xEndA) & (initializationX <= xEndA + maxGap);
		notTooDistantInd = tracker.pointsDistance([xEndA yEndA], [initializationX initializationX]) < MAX_DISPLACEMENT_LINK;
		considered = xStartBInd & notTooDistantInd;

		numLinks = sum(considered);
		if numLinks > 0
			I(numLinkHypothesis:numLinkHypothesis+numLinks-1) = repmat(yEndA, numLinks, 1);
			J(numLinkHypothesis:numLinkHypothesis+numLinks-1) = initializationY(considered);
		end

		numLinkHypothesis = numLinkHypothesis + numLinks;

	end

	I = I(1:numLinkHypothesis-1);
	J = J(1:numLinkHypothesis-1);
	S = ones(numLinkHypothesis-1, 1);
	H = sparse(I, J, S, numTracklets, numTracklets);
end