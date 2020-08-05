diary('Evaluation.txt');
addpath('../code');

% dendrogram(linkList);
% listSize = size(data,1);
% currentRow = [2*listSize-1];

% currentRow = [8930; 8959; 8928; 8956; 8951; 8954; 8942; 8964; 8961; 8962; 8949; 8960];
currentRow = [60;49;65;62;67;68;42;63;66];
currentRow = currentRow + 8900;
[LU_all,occ_all] = countElementOccurences(catList);

result = cell(0);
while (~isempty(currentRow))
    row = currentRow(1);
%             featureList{row,4} = calcLoss(linkList,featureList, row);
    classList = traceLinkageToBinary(linkList,row);
    L = catList(classList>0);
    [LU,occ] = countElementOccurences(L);

    fprintf('Row: %d\n',row);
    fprintf('Row, \t Category, \t\t Percentage of cat \t percentage of row\n');
    rowTot = sum(occ);
    for i = 1:length(LU)
        occPercentage = occ(i)/ occ_all(find(strcmp(LU_all,LU{i})));
        occRowPercentage = occ(i)/ rowTot;
        fprintf('%d, \t %s, \t \t %f, \t %f \n',row,LU{i},occPercentage, occRowPercentage);

        resultRow = size(result,1)+1;
        result{resultRow,1} = row;
        result{resultRow,2} = LU{i};
        result{resultRow,3} = occPercentage;
        result{resultRow,4} = occRowPercentage;
    end

    currentRow = currentRow(2:end);
end

diary off
%%

warning('off','MATLAB:legend:IgnoringExtraEntries')
diary('Evaluation2.txt');
currentRow = [60;49;65;62;67;68;42;63;66];
currentRow = currentRow + 8900;
LU_all = strrep(LU_all,'_',' ')
% currentRow = [8960; 8956; 8951; 8954; 8942; 8964; 8961; 8962; 8949; 8960];
% imFolder = 'im/';
% mkdir(imFolder)
thresh = 0.05;
ledList = {};

for i = 1:length(currentRow)
    row = currentRow(i);
    led = strrep(result([result{:,1}] == row,2),'_',' ');
    toPlot = [result{[result{:,1}] == row,4}];
    useMap = toPlot>thresh;
    toPlot = toPlot(useMap);
    led = led(useMap);
    ledList = [ledList;led(1:length(toPlot))];
    
end

ledU_name = unique(ledList);
ledU = zeros(length(ledU_name),1);
for l = 1:length(ledU_name)
    ledU(l) = find(strcmp(ledU_name(l),LU_all));
end

%%
% subplot(3,4)
currentRow = [60;49;65;62;67;68;42;63;66];
currentRow = currentRow + 8900;
fig1 = figure('Position',[100 100 500 500]); 
hold on;
set(gca,'color','none');
tcm = colormap(jet(length(ledU)));
p = struct;
i = 1;
while (~isempty(currentRow))
    p(i).row = currentRow(1);
%     M = result([result{:,1}] == row,:);
%     test = strrep(L
    p(i).led = strrep(result([result{:,1}] == p(i).row,2),'_',' ');
    toPlot = [result{[result{:,1}] == p(i).row,4}];
%     toPlot = toPlot;
    
    p(i).useMap = toPlot>thresh;
    p(i).toPlot = toPlot(p(i).useMap);
    p(i).led = p(i).led(p(i).useMap);
    xy = [mod(i-1,3)*0.3,0.66-(floor((i-1)/3)*0.33),0.3,0.3];
    p(i).plot = subplot('position',xy);
    h = pie(p(i).toPlot);
    title(['Cluster ' num2str(i)],'FontSize',12,'FontWeight','normal','Interpreter','tex');
    ht = findobj(h,'Type','text');
    for ii = 1:length(ht)
        ht(ii).Visible = 'off';
    end
    hp = findobj(h,'Type','patch');
    for ii = 1:length(hp)
%         p(i).led(ii)
        featName = find(strcmp(LU_all,p(i).led(ii)));
        colToUse = find(featName==ledU);
        hp(ii).FaceColor = tcm(colToUse,:);
    end
    p(i).h = h;
    currentRow = currentRow(2:end);
    i = i + 1;
    
end
% hSub = subplot(4,1,4); plot(1,1,1,1,1,1,1,1);
% legend(led,'position',get(hSub,'position'),'Orientation','vertical','Box','off','FontSize',12);
saveas(gcf,'t1_5','fig');
saveas(gcf,'t1_5','png');
print('t1_5.eps','-depsc2');

% L_p = legend(led,'Location','bestoutside','Orientation','vertical','Box','off','FontSize',12);

% saveas(gcf,'t2','fig');
% saveas(gcf,'t2','png');
diary off
%%

figure;
temPlot = ones(length(ledU),1);
h = pie(temPlot);

% led = strrep(result([result{:,1}] == p(i).row,2),'_',' ');

set(h,'Visible','off');
ht = findobj(h,'Type','text');
for ii = 1:length(ht)
    ht(ii).Visible = 'off';
end
hp = findobj(h,'Type','patch');
for ii = 1:length(hp)
    hp(ii).FaceColor = tcm(ii,:);
end
legend(ledU_name,'Location','north','Orientation','vertical','Box','off','FontSize',14);

saveas(gcf,'leg_5','fig');
saveas(gcf,'leg_5','png');
print('leg_5.eps','-depsc2');


% %%
% row = 8930;
% %     M = result([result{:,1}] == row,:);
% %     test = strrep(L
% led = strrep(result([result{:,1}] == row,2),'_',' ');
% toPlot = [result{[result{:,1}] == row,4}];
% toPlot = toPlot;
% 
% toPlot = toPlot(toPlot>thresh);
% figure;
% h = pie(toPlot);
% 
% ht = findobj(h,'Type','text');
% for i = 1:length(ht)
%     ht(i).Visible = 'off';
% end
% 
% %     [result{[result{:,1}] == 8930,4}]
% legend(led,'Location','eastoutside','Orientation','vertical','Box','off','FontSize',12);
% tit_graph = ['Label Distribution for Cell ' num2str(row)];
% title(tit_graph)
% tit_f = [imFolder 'pie_' num2str(row)];
% set(gca,'color','none')
% saveas(gcf,tit_f,'fig');
% saveas(gcf,tit_f,'png');
% 
% 
% 
% %%
% 
% led = strrep(result([result{:,1}] == row,2),'_',' ');
% toPlot = [result{[result{:,1}] == row,4}];
% toPlot = toPlot/100;
% toPlot = toPlot(toPlot>thresh);
% toPlot
% h = pie(toPlot)
% hp = findobj(h,'Type','patch');




