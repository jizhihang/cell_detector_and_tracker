function prepareFeatureMatrixForRobustMatcher(numAnnotatedFrames, outputFile)

	%{
		This script prepares a matrix containing pairs of cell descriptors and a third objective column indicating if they are the same (that is if the cells are DIRECTLY linked)

		The descriptors are obtained from the cell_detector as a by-product of detecting cells. Additionally a cell location is concatenated to that vector.

		The objective column is obtained from the user annotations of links in the dataset. It is important for the purpose of learning a good matcher that the annotations are as complete possible. 
	%}

	% Must not train on dots that don't have links, as these may be missing value

	global DSIN DSOUT;

	fprintf('Preparing the feature matrix to train Robust linker\n')

	matAnnotationsIndices = DSIN.getMatfileIndices();
	matAnnotationsIndices = matAnnotationsIndices(1:numAnnotatedFrames);


	numFrames = numel(matAnnotationsIndices);
	X = [];

	% First, associate each annotation with the corresponding feature vector
	% Drop any detected cells that don't have annotation, or annotations with missing detections
	metaStartIdx = 1;
	startIdx = matAnnotationsIndices(metaStartIdx);

	% Initialize the tracklets with the first frame that has a detection result

	while true
		% Load annotations and detections for first image
		[dotsGtA, linksA] = DSIN.getDotsAndLinks(startIdx);
		[dotsDetA, descriptorsA] = DSOUT.get(startIdx);

		if isempty(dotsDetA)
			metaStartIdx = metaStartIdx + 1;
			startIdx = matAnnotationsIndices(metaStartIdx);
			continue
		end
			
		[descriptorsA, permA, IA] = tracker.getAnnotationDescriptors(dotsGtA, dotsDetA, descriptorsA);
		[descriptorsA, ~] = tracker.combineDescriptorsWithDots(descriptorsA, dotsGtA);

		descriptorsA = descriptorsA(find(IA), :);
		dotsGtA = dotsGtA(find(IA), :);
		linksA = linksA(find(IA));

		break
	end

	numLinks = 0;

	for i=metaStartIdx:(numFrames-1)
		matIdx = matAnnotationsIndices(i+1);

		% Load annotations and detections for next image
		[dotsGtB, linksB] = DSIN.getDotsAndLinks(matIdx);
		[dotsDetB, descriptorsB] = DSOUT.get(matIdx);

		if ~isempty(dotsDetB)
			[descriptorsB, permB, IB] = tracker.getAnnotationDescriptors(dotsGtB, dotsDetB, descriptorsB);

			% TODOif there is a matching descritor for the dot, process, else
			[descriptorsB, ~] = tracker.combineDescriptorsWithDots(descriptorsB, dotsGtB);
			descriptorsB = descriptorsB(find(IB), :); dotsGtB = dotsGtB(find(IB), :); linksB = linksB(find(IB), :);

			%% Clean linksA:
			% For each value in linksA that matches a find(IB), I need to elimintate it,
			% and all the bigger values decrease by 1.
			badVals = find(~IB); % Eliminte this values from linksA
			for j=1:numel(badVals)
				badVal = badVals(j);
				% Elimintae the value from LinksA by placing a 0 in its location
				linksA(find(linksA == badVal)) = 0;
				% Find all in linksA bigger than badVal and decrease them by 1
				biggerIdx = find(linksA > badVal);
				linksA(biggerIdx) = linksA(biggerIdx) - 1;
				% decrease all values of badVal by 1
				badVals = badVals - 1;
			end

			if ~any([isempty(descriptorsA) isempty(descriptorsB)])
				numLinks = numLinks + numel(find(linksA));
				M = tracker.buildTrainMatrixForFramePair(descriptorsA, descriptorsB, linksA);
				X = vertcat(X, M);
			end
		
		end
		linksA = linksB; descriptorsA = descriptorsB;
		dotsGtA = dotsGtB; dotsDetA = dotsGtB;
	end

	if numLinks == 0
		error('Please annotate the dataset with links. I cannot learn if you dont teach me properly')
	end

	fprintf('Done training robust matcher classier on %d links\n', numLinks)
	save(outputFile, 'X')

	% X = normalizeRange(X, {1:2});
	% imagesc(X)
end