function classList = traceLinkageToBinary(linkList, rowIndex)
%% class = traceLinkageToBinary(linkList, rowIndex)
% This function accepts a linkList and a rowIndex, and performs a transform
% to provide a classification list for all the data points in the original
% list. From a row index, if the data falls under column 1 (lower number)
% then it is given a class of 1, if it falls under column 2 (higher number)
% then it is given a class of 2. Any data not included in that branch of
% the hierarchy is given a class of 0
% linkList - the input result from linkages
% rowIndex - the row on which to split the data

listSize = size(linkList,1)+1;
c(1) = linkList(rowIndex,1);
c(2) = linkList(rowIndex,2);
for i = 1:2
    if (c(i) > listSize)
        c(i) = c(i) - listSize;
    end
end

leafList1 = traverseDownOneStep(linkList,[],c(1));
leafList2 = traverseDownOneStep(linkList,[],c(2));

classList = zeros(listSize,1);
classList(leafList1) = c(1);
classList(leafList2) = c(2);


end

