clearvars;
load('AdobeStratified.mat');
morefeatures = true;
idxvar = (1:1450);
count = 1;
featuredata = struct('IdxVar', [], 'FeatureNamesRanked', {}, 'FeatureImportance', [], 'OOBError', [], 'LastOOBError', [], 'EMClusters', [], 'AIC', [], 'PreviousAIC', []); 

while(morefeatures)
    DataTrain = DataTrain(:, idxvar);
    FeatureNames = FeatureNames(idxvar);
    idxvar = (1:length(FeatureNames));
    fprintf('\n Growing a Random Forest of 200 trees using %i features\n',length(idxvar))
    
    rng(1945,'twister')
    tic
    options = statset('UseParallel', true);
    b = TreeBagger(200, DataTrain, LabelsTrain,'OOBVarImp','On', 'SampleWithReplacement', 'Off', 'FBoot', 0.632, 'Options', options);
    toc
    
    oobErr = oobError(b);
    LastoobErr = oobErr(end);
    
    fprintf('\n The cumulative OOB Error at 200 trees is %f\n', LastoobErr);
    
    Indices = crossvalind('Kfold', size(DataTrain, 1), 10);
    
    AICInitial = 1e16;
    AICNext = -1e16;
    AICAvg = zeros(10, 1);
    NumClusters = 1;
    
    while(AICNext <= AICInitial)
        
        if(NumClusters ~= 1)
            AICInitial = AICNext; 
        end
        NumClusters = NumClusters + 1;
        
        fprintf('\n Performing EM using 10 fold CV and %i clusters and %i features\n', NumClusters, length(idxvar))
        
        for i = 1:10
           
            emidx = (Indices == i); emidx = ~emidx;
            
            EMDataTrain = DataTrain(emidx, :);
            GMModelCV = fitgmdist(EMDataTrain, NumClusters, 'RegularizationValue', 1e-5);
            AICAvg(i) = GMModelCV.AIC;
        end
        
        AICNext = mean(AICAvg);
        fprintf('The average AIC was %f\n', AICNext);
    end
    
    FI = b.OOBPermutedVarDeltaError;
    
    [FI,I]=sort(FI, 'descend');
    idxvar = idxvar(I);
    FeatureNamesRanked = FeatureNames(I);
    
    featuredata(count).IdxVar = idxvar;
    featuredata(count).FeatureNamesRanked = FeatureNamesRanked;
    featuredata(count).FeatureImportance = FI;
    featuredata(count).OOBError = oobErr;
    featuredata(count).LastOOBError = LastoobErr;
    featuredata(count).EMClusters = NumClusters;
    featuredata(count).AIC = AICNext;
    featuredata(count).PreviousAIC = AICInitial;    
    
    idxRemove = round((length(idxvar) / 100)* 1);
    fprintf('\n %i features will be removed.\n', idxRemove)
    idxRemove = (length(idxvar) - idxRemove);
    idxvar = idxvar(1:idxRemove);
    count = count + 1;
    
    save('Results1Percent.mat', 'featuredata');
    
    if(length(idxvar) == 2)
        morefeatures = false;
    end
end