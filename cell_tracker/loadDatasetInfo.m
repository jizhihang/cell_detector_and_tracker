function dataParams = loadDatasetInfo(dataset)
%This is used to setup (and load) the parameters of the dataset; use as
%template for new datasets.
%
%INPUT
%   dataSet = identifier of the data set as set in the switch-case
% OUTPUT
%   dataParams = a struct containing
%         imExts      =  image extension
%         imPrefix   =  image prefix
%         imDigits   =  number of digits in image name
%         dataFolder =  folder that contains the data (if training data, it must contain the both the images and the annotations)
%         outFolder  = folder to save results and intermediary data
%         maxGaps = gaps to try to close
%         linkerClassifierParams = a struct with parameters for the join tracklets classifier
    
%Defaults
imPrefix = 'im';
imExts = {'pgm', 'png', 'jpg'};
imDigits = 3;
maxGaps = [1 3 6 9]; % for the linker
rootFolder = fullfile('..', 'data');
% Kinit = 1.5;
% Kterm = 1.5;
% Kfp = 1.3;
% Klink = 1;

Kinit = 1;
Kterm = 1;
Kfp = 1;
Klink = 1;


switch dataset
    case 1 %PhaseContrast
        %-TRAINING DATA SET-%
        dataFolder = fullfile(rootFolder, 'phasecontrastIN');
        outFolder = fullfile(rootFolder, 'phasecontrastOUT');
        imExts = {'pgm'};
        imageDims = [];  % TODO [height width]
    case 2 %LungGreen
        %-TRAINING DATA SET-%
        dataFolder = fullfile(rootFolder, 'series30green');
        outFolder = fullfile(rootFolder, 'series30greenOUT');
        imExts = {'pgm'};
        imageDims = [512 512];  % TODO [height width]
    case 3 %LungRed
        %-TRAINING DATA SET-%
        dataFolder = fullfile(rootFolder, 'lungredIN');
        outFolder = fullfile(rootFolder, 'lungredOUT');
        imExts = {'pgm'};
        imageDims = [512 512];  % TODO [height width]
    case 4 %KidneyGreen
        %-TRAINING DATA SET-%
        dataFolder = fullfile(rootFolder, 'kidneygreenIN');
        outFolder = fullfile(rootFolder, 'kidneygreenOUT');
        imExts = {'pgm'};
        imageDims = [512 512];  % TODO [height width]
    case 5 %KidneyRed
        %-TRAINING DATA SET-%
        dataFolder = fullfile(rootFolder, 'kidneyredIN');
        outFolder = fullfile(rootFolder, 'kidneyredOUT');
        imExts = {'pgm'};
        imageDims = [512 512];  % TODO [height width]
    case 6 %KidneyRed
        %-TRAINING DATA SET-%
        dataFolder = fullfile(rootFolder, 'dumy');
        outFolder = fullfile(rootFolder, 'dumyOUT');
        imExts = {'pgm'};
        imageDims = [512 512];  % TODO [height width]
end

% Parameters for training the classifier for joining tracklets
linkerClassifierParams = struct(...
    'MIN_TRACKLET_LENGTH', 0,...
    'MAX_GAP', max(horzcat(5, maxGaps)),...
    'outputFileMatrix', fullfile(outFolder, 'linkerClassifierModelMatrix.mat'),...
    'outputFileModel', fullfile(outFolder, 'linkerClassifierModel.m'),...
    'algorithm', 'ANN'...  % 'NB', 'ANN'
);

% Parameters for training the classifier for creating robust tracklets
robustClassifierParams = struct(...
    'outputFileMatrix', fullfile(outFolder, 'robustClassifierModelMatrix.mat'),...
    'outputFileModel', fullfile(outFolder, 'robustClassifierModel.mat'),...
    'algorithm', 'ANN'...  % 'ANN', 'NB'
);

outputTrackletsFile = fullfile(outFolder, 'trajectories.mat');

if exist(dataFolder,'dir') ~= 7
    error('Data folder not found')
end

if exist(outFolder,'dir') ~= 7
    error('Data OUT folder not found')
end

dataParams.imExts      =      imExts;
dataParams.imPrefix   =   imPrefix;
dataParams.imDigits   =   imDigits;
dataParams.dataFolder = dataFolder;
dataParams.outFolder  =  outFolder;
dataParams.maxGaps  =  maxGaps;
dataParams.linkerClassifierParams = linkerClassifierParams;
dataParams.robustClassifierParams = robustClassifierParams;
dataParams.imageDimensions = imageDims;
dataParams.Kinit = Kinit;
dataParams.Kterm = Kterm;
dataParams.Kfp = Kfp;
dataParams.Klink = Klink;
dataParams.outputTrackletsFile = outputTrackletsFile;

end
