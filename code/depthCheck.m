function linkList = depthCheck(linkList)
%% linkList = depthCheck(linkList)
% depthCheck will extend a linkList, created by the linkages algorithm, and
% append an extra column on the end which indicated the depth of the
% linkage, so the top level is 1, and each following level is the number of
% links needed to get to the top level - which could be considered the
% number of rules that exist. 
% 
% The other method for measuring depth would be
% to look at the value of the linkage distance - thresholding and grouping
% the linkage distances could be beneficial for some analysis.

listSize = size(linkList,1)+1;

linkList = cat(2,linkList, zeros(size(linkList,1),1));
currentRow = size(linkList,1);
r = [0;0];
% depth = 1;

linkList(currentRow,end) = 1;
% depth = depth + 1;
%%
while (~isempty(currentRow))
    row = currentRow(1);
    for i = 1:2
        r(i) = linkList(row,i);
        if(r(i) > listSize)
            r(i) = linkList(row,i) - listSize;
            linkList(r(i),end) = linkList(currentRow(1),end)+1;
            currentRow = [currentRow; r(i)];
        end
    end
    currentRow = currentRow(2:end);
end
end

