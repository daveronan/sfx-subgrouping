finalidx =[];
for i=1:length(FeatureNames)
    for j=1:length(FindFeatures)
        if(isequal(FindFeatures(j), FeatureNames(i)))
            finalidx = [finalidx i];
        end
    end
end