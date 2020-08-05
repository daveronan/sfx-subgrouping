
%%
% load('testData.mat');
% [linkList, featureList]= treeLinkFeatures(data,5);
% save('testResults.mat','linkList','featureList');

%%
load('adobeDataNorm.mat')
[linkList, featureList]= treeLinkFeatures(AdobeNormalised,5,featureNames);
save('adobeResults.mat','linkList','featureList');
% exit

%%
