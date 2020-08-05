function [l,se] = calcLoss(linkList,featureList, row)

classList = traceLinkageToBinary(linkList,row);
X = data(classList>0,featureList{row,1});
Y = classList(classList>0);
[l,se] = loss(featureList{row,3},X,Y);
end
