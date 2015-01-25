function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta
%               You should set J to the cost.

h = X*theta;
temphy1 = h-y;
%temphy2 = temphy1 ^2;
fact = 1/(2*m);
%temphy3 = fact*temphy2
tJ=sumsq(temphy1,1);
J = tJ*fact;




% =========================================================================

end
