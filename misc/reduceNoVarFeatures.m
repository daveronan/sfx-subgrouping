noVar = [];
for i = 1:size(data,1)
    if(var(data(i,:)) == 0)
        noVar = [noVar;i];
    end
end

%%
data(noVar,:) = [];
noVarfeatures = features(noVar);
features(noVar) = [];


%%

