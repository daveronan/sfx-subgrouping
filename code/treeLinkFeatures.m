function [linkList, featureList]= treeLinkFeatures(data, depthThresh, featureNames)
%% [linkList, featureList]= treeLinkFeatures(data, depthThresh, featureNames)
% given a dataset, a hierarchical cluster of the data is produced, and then
% the data is traversed, such that, for each split in the data, a set of
% features are produced, which are the ranked features that can be used to
% separate the given dataset at that point.
% data is the nxm matrix of content, n is the number of samples and m is
% the number of features.
% depthThresh is a list of the range of tree depths to traverse from the
% aglomerative clustering tree. A single value of depthThresh, will assume
% 1:depthThresh. For analysis of a single layer of the tree, pass a list of
% two values, both of which are the layer to be analysed.
% feature names is the list of features, so that grown trees have suitable
% names. No feature names will result in the feature number being returned.
% featureList corresponds to the rows in linkList, with the form column 1
% is the 5 most relevant features, column 2 is the depth and column 3 is a
% decision classification tree for the decision - perhaps this should be in
% the form of a struct instead?



if(nargin < 3)
    featureNames = 1:size(data,2);
end
if(nargin < 2)
    depthThresh = 999;
end

if (length(depthThresh) == 1)
    depthThresh = 1:depthThresh;
end
    
linkList = aglomCluster(data);
linkList = depthCheck(linkList);
listSize = size(data,1);

% linkList(:,4) = 0;
featureList = cell(listSize-1,3);
currentRow = [2*listSize-1];

%%
while (~isempty(currentRow))
    if(currentRow(1) > listSize)
        row = currentRow(1) - listSize
%         rD = linkList(row,4);
        if any(linkList(row,4)==depthThresh)
            classList = traceLinkageToBinary(linkList, row);
            featureList{row,1} = rfFeatureSelection(data(classList>0,:), classList(classList>0));
            featureList{row,2} = linkList(row,4);
            featureList{row,3} = fitctree(data(classList>0,featureList{row,1}),classList(classList>0),'PredictorNames',featureNames(featureList{row,1}));
        end
        currentRow = [currentRow; linkList(row,1); linkList(row,2)];
    end
    currentRow = currentRow(2:end);
    save('partialResults.mat');
end

end