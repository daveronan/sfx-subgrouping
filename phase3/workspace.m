sL = size(featureList);

for i = 1:sL(1)
    if(isempty(featureList{i,2}))
         featureList{i,2} = -1;
    end
end

depthMap = cell2mat(featureList(:,2));
%%

for ii = 1:max(depthMap)
    ii;
    index = find(depthMap ==ii)';
    count = 1;
    for i = index
        f = featureList{i,1};
        ii
        count
        featsMap{ii,count} = featureNames(f);
        count = count +1;
    end
    featsMap{ii,count} = index;
%     pause
end