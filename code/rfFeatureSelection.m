function featureVector = rfFeatureSelection(data, labels, numFeatures, iterMethod, numTrees, featureVector)
%% rfFeatureSelection(data, labels, numFeatures, iterMethod, numTrees, featureVector)
%
% using random forests to perform feature selection for a given data set
% data has size (x,y), where x is the number of labels and y, the number of
% features. 
% labels is the set of labels for the data
% numFeatures is the dimension of the output vector (default 5)
% iterMethod is the method for which the features are cut down
%       * 'onePass' will simply select the top (numFeatures) features and
%       report them 
%       * 'cutX' will iteratively cut the bottom X percent of
%       features out, and perform random forest feature selection on the
%       new set, until the desired number of features has been returned
%       * 'featureDeltaErr' will cut down the number of features based on
%       the number of features that negatively impact the results, as given
%       by the OOBPermutedVarDeltaError
% featureVector is a list of the features to use, for recursive purposes.

if(length(labels) ~= size(data,1))
    error('labels and data do not match up');
end

if(nargin < 2)
    error('must pass data and labels into function')
end
if(nargin < 3)
    numFeatures = 5;
end
if(nargin < 4)
    iterMethod = 'onePass';
end
if(nargin < 5)
    numTrees = 200;
end
if(nargin < 5)
    featureVector = 1:size(data,2);
end


if(length(featureVector) > numFeatures)
    options = statset('UseParallel', true);
    b = TreeBagger(numTrees, data(:,featureVector), labels,'OOBVarImp','On',...
        'SampleWithReplacement', 'Off','FBoot', 0.632,'Options', options);
    [FI,I] = sort(b.OOBPermutedVarDeltaError,'descend'); 
    featureVector = featureVector(I);

    if(strcmp(iterMethod,'onePass'))
        featureVector = featureVector(1:numFeatures);
    elseif(strcmp(iterMethod(1:3),'cut'))
        cutPercentage = str2double(iterMethod(4:end));
        cutSize = max(floor(length(featureVector)*cutPercentage/100),1);
        if(length(featureVector) - cutSize < numFeatures)
            cutSize = length(featureVector) - numFeatures;
        end
        featureVector = featureVector(1:end-cutSize);
        featureVector = rfFeatureSelection(data, labels, numFeatures, iterMethod, numTrees, featureVector);
    elseif(strcmp(iterMethod,'featureDeltaErr'))
        cutSize = sum(FI<0);
        if(length(featureVector) - cutSize < numFeatures)
            cutSize = length(featureVector) - numFeatures;
        end
        featureVector = featureVector(1:end-cutSize);
        featureVector = rfFeatureSelection(data, labels, numFeatures, iterMethod, numTrees, featureVector);
    end
end
end