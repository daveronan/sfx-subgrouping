function linkList = aglomCluster(data, clusterMethod, distanceMetric, numClusters)
%% aglomCluster(data, clusterMethod, distanceMetric, numClusters)
% This function performs aglomerative clustering on a given data set,
% allowing the interpretation of a hierarchical data, and plotting a
% dendrogram.
%
% data in the format of of each row is an observation and each column is a
% feature vector clusterMethod;
%     * 'average'     Unweighted average distance (UPGMA)
%     * 'centroid'	Centroid distance (UPGMC), appropriate for Euclidean
%     distances only
%     * 'complete'	Furthest distance
%     * 'median'      Weighted center of mass distance (WPGMC),appropriate
%     for Euclidean distances only
%     * 'single'      Shortest distance
%     * 'ward'        Inner squared distance (minimum variance algorithm),
%     appropriate for Euclidean distances only (default)
%     * 'weighted'	Weighted average distance (WPGMA)
% distanceMetric
%     * 'euclidean' Euclidean distance (default).
%     * 'seuclidean' Standardized Euclidean distance. Each coordinate
%     difference between rows in X is scaled by dividing by the
%     corresponding element of the standard deviation S=nanstd(X). To
%     specify another value for S, use D=pdist(X,'seuclidean',S).
%     * 'cityblock' City block metric.
%     * 'minkowski' Minkowski distance. The default exponent is 2. To
%     specify a different exponent, use D = pdist(X,'minkowski',P), where P
%     is a scalar positive value of the exponent.
%     * 'chebychev' Chebychev distance (maximum coordinate difference).
%     * 'mahalanobis'	Mahalanobis distance, using the sample covariance
%     of X as computed by nancov. To compute the distance with a different
%     covariance, use D = pdist(X,'mahalanobis',C), where the matrix C is
%     symmetric and positive definite.
%     * 'cosine' One minus the cosine of the included angle between points
%     (treated as vectors).
%     * 'correlation' One minus the sample correlation between points
%     (treated as sequences of values).
%     * 'spearman' One minus the sample Spearman's rank correlation between
%     observations (treated as sequences of values).
%     * 'hamming' Hamming distance, which is the percentage of coordinates
%     that differ.
%     * 'jaccard' One minus the Jaccard coefficient, which is the
%     percentage of nonzero coordinates that differ.
% numClusters is the number of final clusters produced by the dendrogram,
% if 0 (default), then will infer from data

if(nargin<2)
    clusterMethod = 'ward';
end
if(nargin<3)
    distanceMetric = 'euclidean';
end
if (nargin<4)
    numClusters = 0;
end

distMap = pdist(data, distanceMetric);
linkList = linkage(distMap, clusterMethod);
[~,T] = dendrogram(linkList,numClusters,'Orientation','left');


end