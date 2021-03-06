% clear all;

load(fullfile('..', 'data', 'series30greenOUT', 'linkerClassifierTrainMatrix.mat'))

idx = ones(1, size(X, 2));
% idx = std(X) > 0.005;
X = X(:, idx);

[x minimum maximum] = normalizeRange(X);

NB = fitNaiveBayes(x, Y);

save('match_tracklet_predictor_nb.mat', 'NB', 'idx', 'minimum', 'maximum');

t = testLinkerClassifierNB(X);
cMat1 = confusionmat(double(Y), double(t>0.9))