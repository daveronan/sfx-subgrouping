tic
rng(1945,'twister')
options = statset('UseParallel', true);
b = TreeBagger(50, data, labels,'OOBVarImp','On', 'SampleWithReplacement', 'Off', 'FBoot', 0.632, 'Options', options);
% b = TreeBagger(500, DataTrain63, LabelsTrain,'OOBVarImp','On', 'SampleWithReplacement', 'Off', 'InBagFraction', 0.632, 'Options', options);
toc
figure
plot(oobError(b))
oobErr = oobError(b);
xlabel('Number of Grown Trees')
ylabel('Out-of-Bag Classification Error')
figure
bar(b.OOBPermutedVarDeltaError)
xlabel 'Feature Number'
ylabel 'Out-of-Bag Feature Importance'
FI = b.OOBPermutedVarDeltaError;
r = corrcoef(NormXtrain);
figure
imagesc(abs(r))
NormXtrainOld = NormXtrain;
idxvarOld = idxvar;
FeatureNamesOld = FeatureNames;
oobErrOld = oobErr;