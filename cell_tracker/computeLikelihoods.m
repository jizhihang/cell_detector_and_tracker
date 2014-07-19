function Liks = computeLikelihoods(tracklets, hypothesis, hypTypes, options)
	% COMPUTELIKELIHOODS Computes the likelihood of each hypothesis
	% Inputs:
	% 	tracklets = the tracklets matrix generated by generateTracklets()
	% 	hypothesis = the hypothesis matrix generate by generateHypothesisMatrix()
	%	hypTypes = a vector indicating the type of hypothesis, as generateb by generateHypothesisMatrix()
	% 	options = a struct with options
	%		[matcher] = ('ANN', 'NB')  % which matcher model to use to join tracklets
	%		imageDimensions = a 2d vector containing source images height and width
	% Outputs:
	% 	Liks = a column vector of length numHypothesis containing likelihoods for each hypothesis

	%------------------------------------------------------------------Options
	if nargin < 4; options = struct; end


	matcher = 'ANN';

	if isfield(options, 'matcher'); 
		if ismember(options.matcher, {'NB' 'ANN'})
			matcher = options.matcher;
		else
			error('Macther %s is not valid. It must be one of "NB", "ANN"', options.matcher);
		end
	end

	if ~isfield(options, 'imageDimensions')
		error('Options should have imageDimensions field set.')
	end

	% This should mirror the types in generateHypothesisMatrix()
	TYPE_INIT = 1;
	TYPE_TERM = 2;
	TYPE_FP = 3;
	TYPE_LINK = 4;

	MISS_DETECTION_RATE = 0.3;  % TODO: load real value from an external param
	% file

	%--------------------------------------------------------Preallocate space
	numHypothesis = size(hypothesis, 1);
	numTracklets = size(tracklets, 1);

	% Likelihood vector
	Liks = zeros(numHypothesis, 1);

	%-------------------------------------------------Precompute probabilities

	linkHypothesisIdx = find(hypTypes == TYPE_LINK);
	numLinkHypothesis = size(linkHypothesisIdx);
	linkHypothesis = hypothesis(linkHypothesisIdx, :);
	pLinks = computePlink();
	[pFPs, pTPs] = computeTruthnessProbs(1:numTracklets);
	pInit = computePinit();
	pTerm = computePterm();

	%------------------------------------------------------Compute likelihoods

	% Compute initialization hypothesis
	Liks(hypTypes == TYPE_INIT) = log(pInit) + 0.5 * log(pTPs);

	% Compute termination hypothesis
	Liks(hypTypes == TYPE_TERM) = log(pTerm) + 0.5 * log(pTPs);

	% Compute false positive hypothesis
	Liks(hypTypes == TYPE_FP) = log(pFPs);

	% Compute link hypothesis
	for i=1:numel(linkHypothesisIdx)
		[~, J] = find(linkHypothesis(i, :));
		Liks(linkHypothesisIdx(i)) = log(pLinks(J(1), J(2)-numTracklets)) + 0.5 * log(pTPs(J(1))) + 0.5 * log(pTPs(J(2)-numTracklets));
	end

	function P = computePlink()
		% COMPUTEPLINK for each link hypothesis compute the probability of linking
		% Inputs:
		% 	linkHypothesis= a (sparse) matrix of dimensions numTracklets x numTracklets containing 1 if the tracks could potentially be linked
		% Outputs:
		% 	P = the probability of linking the pairs of tracklets as evaluated by a learned model, in the form a of matrix the same size as linkHypothesis;

		%----------------------------------------------------Preallocate space
		numLinkHypothesis = size(linkHypothesis, 1);
		trackletPairs = zeros(numLinkHypothesis, 2);
		P = sparse([],[],[], numTracklets, numTracklets);
		% descriptorPairs contains pairs of augemented descriptors of possibly intenracting tracklets, use to compute the link probabilities.
		%---------------------------------------Get tracklet pairs descriptors

		for i=1:numLinkHypothesis
			[~, J] = find(linkHypothesis(i, :));
			trackletPairs(i, :) = [J(1) J(2)-numTracklets];
		end

		X = computeTrackletMatchFeatures(tracklets, trackletPairs, options);

		%---------------------------------------------------Evaluate the Plink

		if strcmp(matcher, 'ANN')
			matchP = testLinkerClassifierANN(X')';
		else
			matchP = testLinkerClassifierNB(X);
		end
		for i=1:numLinkHypothesis
			P(trackletPairs(i, 1), trackletPairs(i, 2)) = matchP(i);
		end
	end

	function [FP, TP] = computeTruthnessProbs(trackletIdx)
		% COMPUTETRUTHNESSPROBS Computes the probability that a tracklet is a false positive or a true positive
		% Inputs:
		% 	trackletIdx = indices of tracklets
		% Outputs:
		% 	FP = corresponding false positive probability
		% 	TP = corresponding true positive probability
		
		len = sum(max(tracklets(trackletIdx, :, :), [], 3) ~= 0, 2);
		FP = MISS_DETECTION_RATE .^ len;
		TP = 1 - FP;
	end

	function pInit = computePinit()
		% COMPUTEPINIT Returns the probability of initialization for each tracklet
		% Pinit = 1 - max(Plink_prev) where Plink_prev are the probabilities of
		% linking any of the previous trackets (up to maxGap in the past) to it.

		% It relies on pLinks, which is a numTrackletsxnumTracklets matrix
		% containing the probabilities of linking each tracklet to another

		pInit = 1 - max(pLinks, [], 1)';
	end

	function pTerm = computePterm()
		% COMPUTEPINIT Returns the probability of initialization for each tracklet
		% Pinit  =1 - max(Plink_next) where Plink_next are the probabilities of
		% linking the current track to any of the next (up to maxGap in the future).

		% It relies on pLinks, which is a numTrackletsxnumTracklets matrix
		% containing the probabilities of linking each tracklet to another

		pTerm = 1 - max(pLinks, [], 2);
	end
end