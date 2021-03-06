function trainRobustTrackerModel(options, leaveoneout)
	% Generates a training matrix and trains the robust tracklet model for
	% generating robust tracklets
	% Input:
	% 	//storeID = a string indicating from which dataset to load the data
	% 	options = a struct containing parameters such as
	% 		algorithm = which algorithm to use to train the model
	% 		outputFileMatrix = where to store the intermediate matrix
	% 		outputFileModel = where to store the learned model
	% Output: /

	if nargin < 1
		leaveoneout = 0;
	end

	classifierOpts = options.robustClassifierParams;

	classifierOpts.trajectoriesOutputFile = options.trajectoriesOutputFile;
	
	tracker.prepareFeatureMatrixForRobustMatcher(classifierOpts, leaveoneout);

	dataFile = classifierOpts.outputFileMatrix;
	modelFile = classifierOpts.outputFileModel;

	switch classifierOpts.algorithm
		case 'ANN'
			tracker.trainMatcherRobustClassifierANN(dataFile)
		case 'NB'
			tracker.trainMatcherRobustClassifierNB(dataFile, modelFile)
		otherwise
			error('Please specify a robust trackler training algorithm in the configuration file')
	end
end