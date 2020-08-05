
% define Row

row = 8968;

classList = traceLinkageToBinary(linkList,row);
X = data(classList>0,featureList{row,1});
Y = classList(classList>0);
pDepth = max(featureList{row,3}.PruneList)-1;

T1 = prune(featureList{row,3},'Level',pDepth);
[l,se] = loss(T1,X,Y)

view(T1,'Mode','graph')

%%
pDepth = pDepth-1;

T1 = prune(featureList{row,3},'Level',pDepth);
[l,se] = loss(T1,X,Y)

view(T1,'Mode','graph')

%%
view(T1)