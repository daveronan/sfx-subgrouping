
load('Adobe.mat')
load('Results1Percent.mat')

datamap = featuredata(end).IdxVar;
reduceData = Data(:,datamap);
reduceLabels = Labels(datamap);
%% UNUSED
% reduceFeatures = FeatureNames(datamap);

%% UNUSED
load('Results1Percent.mat')

%% 
% Use Subset of data
reduceFeatures = featuredata(1).FeatureNamesRanked;

dataToUseSize = 500;
dataToUse = ceil(rand(dataToUseSize,1)*size(reduceData,1))';

dMap = pdist(reduceData(dataToUse,:));
clusterMethod = 'ward';
% 'average'     Unweighted average distance (UPGMA)
% 'centroid'	Centroid distance (UPGMC), appropriate for Euclidean distances only
% 'complete'	Furthest distance
% 'median'      Weighted center of mass distance (WPGMC), appropriate for Euclidean distances only
% 'single'      Shortest distance
% 'ward'        Inner squared distance (minimum variance algorithm), appropriate for Euclidean distances only
% 'weighted'	Weighted average distance (WPGMA)

dl = linkage(dMap, clusterMethod);
dendrogram(dl)
incon_sp = inconsistent(dl)
% figure; imagesc(squareform(dMap_sp))
% title('euclidian self similarity');

%%
% Use all data

dMapAll = pdist(reduceData);
clusterMethod = 'ward';
% 'average'     Unweighted average distance (UPGMA)
% 'centroid'	Centroid distance (UPGMC), 
%                     appropriate for Euclidean distances only
% 'complete'	Furthest distance
% 'median'      Weighted center of mass distance (WPGMC),
%                     appropriate for Euclidean distances only
% 'single'      Shortest distance
% 'ward'        Inner squared distance (minimum variance algorithm), 
%                   appropriate for Euclidean distances only
% 'weighted'	Weighted average distance (WPGMA)

dl_all = linkage(dMapAll, clusterMethod);
% [~,T] = dendrogram(dl_all,0)

%%
% print filelist for each cluster

numClusters = 100;
fnames = cell(1,numClusters);
[~,T] = dendrogram(dl_all,numClusters);
plotName = ['data/ClusterWith' num2str(numClusters) 'Elements'];
saveas(gcf, plotName, 'fig');
saveas(gcf, plotName, 'pdf');
for i = 1:numClusters
    numFiles = sum(T==i);
    fnames{i} = Filenames(find(T==i));
end

%
% makeCSV for Weka
% format 

feats = reduceData;

csvOut = num2cell(feats);
csvOut = [csvOut, num2cell(T)];
csvOut = [[reduceFeatures(datamap)', {'Class'}]; csvOut];
cell2csv(['data/wekaReducedFeaturesWithNew' num2str(numClusters) '.csv'],csvOut)


%%
% fnames to CSV

maxLen = size(fnames,2);

for i = 1:maxLen
    depth = size(fnames{i},1);
    for ii = 1:depth
        csvOut(i,ii) = fnames{i}(ii);
    end
end

printString = '';
for i = 1:maxLen
    printString = [printString ' %s, '];
end

fid = fopen('junk.csv','w');
fprintf(fid,[printString '\n'],csvOut{1:end,:});
% fprintf(fid,'%f, %f, %f\n',c{2:end,:})
fclose(fid) ;
% dlmwrite('test.csv', csvOut, '-append') ;

%%
T = cluster(dl_sp,'cutoff',1.3);
figure; plot(T);



%%


T = cluster(dl_sp,'maxclust',2);
plot(T)
%%
T = cluster(dl_sp,'maxclust',3);
plot(T)
%%
T = cluster(dl_sp,'maxclust',4);
plot(T)
T = cluster(dl_sp,'maxclust',5);
plot(T)
T = cluster(dl_sp,'maxclust',6);
plot(T)
T = cluster(dl_sp,'maxclust',7);
plot(T)
T = cluster(dl_sp,'maxclust',8);
plot(T)
T = cluster(dl_sp,'maxclust',9);
plot(T)
%%
T = cluster(dl_sp,'maxclust',10);
plot(T)
%%
T = cluster(dl_sp,'maxclust',100);
plot(T)
%%
median(T)


T = cluster(dl_sp,'maxclust',1000);
median(T)


plot(T)
csvwrite('dataOutput',reduceData);












% dMap_euc = pdist(reduceData);
% dMap_cos = pdist(reduceData,'cos');
% dMap_cos = pdist(reduceData,'cosine');
% dl_euc = linkage(dMap_euc);
% dl_cos = linkage(dMap_cos);
% % dl_sp
% dl_sp(10,:)
% dl_sp(1:10,:)
% sprintf('%f', dl_sp(1:10,:))
% dl_sp(1:10,:)
% format short g
% dl_sp(1:10,:)
% plot(dl_sp(:))
% plot(dl_sp(:,3))
% incon_sp = inconsistent(dl_sp)
