function leaf = traverseDownOneStep(linkList,leaf,row)

%% leaf = traverseDownOneStep(linkList,leaf,row)
% Recursive function which given a linkList, will search a given row, and
% if the row is a leaf, it will append the leaf to the end of the leaf
% list, otherwise, it will recursively call the function to identify the
% two leaves for the branches it has discovered

listSize = size(linkList,1)+1;
if(row > listSize)
    row = row-listSize;
end

if (row == listSize)
    leaf = row;
else
    leaf1 = linkList(row,1);
    leaf2 = linkList(row,2);

    if(leaf1 > listSize)
        leaf = traverseDownOneStep(linkList,leaf,leaf1);
    else
        leaf = cat(1,leaf,leaf1);
    end

    if(leaf2 > listSize)
        leaf = traverseDownOneStep(linkList,leaf,leaf2);
    else
        leaf = cat(1,leaf,leaf2);
    end
end
end