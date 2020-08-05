diary('AnalysisOutput.txt');
dendrogram(linkList);
listSize = size(data,1);
currentRow = [2*listSize-1];

while (~isempty(currentRow))
    if(currentRow(1) > listSize)
        row = currentRow(1) - listSize
        if(~isempty(featureList{row,1}))    
%             featureList{row,4} = calcLoss(linkList,featureList, row);
            classList = traceLinkageToBinary(linkList,row);
            X = data(classList>0,featureList{row,1});
            Y = classList(classList>0);

            [L,se] = loss(featureList{row,3},X,Y);
            featureList{row,4} = [L, se];
            
            pDepth = max(featureList{row,3}.PruneList);
            
            lossVal = 1;
            while (lossVal > 0.2 && pDepth > 1)
                pDepth = pDepth - 1;
                T1 = prune(featureList{row,3},'Level',pDepth);
                lossVal = loss(T1,X,Y);
            end
            fprintf('Row: %d, pDepth = %d, loss = %f\n',row,pDepth,lossVal);
            view(T1);
            currentRow = [currentRow; linkList(row,1); linkList(row,2)];
        end
    end
    currentRow = currentRow(2:end);
end

diary off
%%

