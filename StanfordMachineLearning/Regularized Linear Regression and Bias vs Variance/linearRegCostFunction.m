function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

fact = 1/(2*m);
fact2 = lambda/(2*m);
fact3 = lambda/(m);
tempH = X*theta; %this is Theta transform times X
tempJTheta = tempH - y; %terms inside the summation
tempJThetaSq = sumsq(tempJTheta);  %Sum of the squares from  i= 1 to m
J = fact*tempJThetaSq;

theta1 =  theta(1);
theta1 = theta1*theta1;
thetaSum = sumsq(theta) - theta1; %The  theta zero should not be included in the regularization
 
J = J + (thetaSum*fact2);

% calculation for gradient

temphy1 = tempH - y; % term inside the Summation of grad calc
temphy1 = temphy1*(1/m);
grad =(temphy1'*X);
grad = grad' +(fact3*theta);
temp = fact3*theta(1);
grad(1) = grad(1)-temp;


% =========================================================================

grad = grad(:);

end
