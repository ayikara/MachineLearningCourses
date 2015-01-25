function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returs the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%



ck = accumarray(idx,idx)./unique(idx);
%s1=accumarray(idx,X(:,1),[;],@sum)
%s1=s1./ck;
 %s2=accumarray(idx,X(:,end),[;],@sum)
 %s2=s2./ck;
 %centroids =[s1 s2];
 
 for i = 1 : n
 	s1=accumarray(idx,X(:,i),[;],@sum);
	s1=s1./ck;
	centroids(:,1) = [];
	centroids =[centroids s1];
 end









% =============================================================


end

