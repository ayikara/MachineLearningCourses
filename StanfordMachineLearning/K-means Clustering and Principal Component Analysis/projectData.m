function Z = projectData(X, U, K)
%PROJECTDATA Computes the reduced data representation when projecting only 
%on to the top k eigenvectors
%   Z = projectData(X, U, K) computes the projection of 
%   the normalized inputs X into the reduced dimensional space spanned by
%   the first K columns of U. It returns the projected examples in Z.
%

% You need to return the following variables correctly.
Z = zeros(size(X, 1), K);
%K
%[c,d] =size(X)
%[i,j] =size(U)

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the projection of the data using only the top K 
%               eigenvectors in U (first K columns). 
%               For the i-th example X(i,:), the projection on to the k-th 
%               eigenvector is given as follows:
%                    x = X(i, :)';
%                    projection_k = x' * U(:, k);
%

Ureduce = U(:,1:K);
%[a,b] =size(Ureduce)
%Y =Ureduce'*X';
%[a,b] =size(Y)
xSize =size(X,1);
for i = 1 : xSize
 ix = X(i,:);
 zx = Ureduce'*ix';
 Z(i,:) =zx;
end



% =============================================================

end
