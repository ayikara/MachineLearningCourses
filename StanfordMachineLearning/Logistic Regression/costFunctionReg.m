function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta


fact = 1/(m);
fact2 = lambda/(2*m);
fact3 = lambda/(m);

temp1 = X*theta; %this is Theta transform times X

tempH = sigmoid(temp1);
logH = log(tempH);
log1mH =log(1 - tempH);

tempJT1 = -1 * y.*logH; % The first term of the J(theta) calculation .. Need to use the element wise multiplication
tempJT2 = (1 - y).*log1mH;  %second term of the J(theta) calculation

tempJTheta = tempJT1 - tempJT2; %terms inside the summation
J = fact*sum(tempJTheta); %1/m x y.log(h) - (1-y).log(1-h);
theta1 =  theta(1);
theta1 = theta1*theta1;
thetaSum = sumsq(theta) - theta1;
J = J + (fact2*thetaSum);

% calculation for gradient

temphy1 = tempH - y; % term inside the Summation of grad calc
temphy1 = temphy1*(1/m);
grad =(temphy1'*X);
grad = grad' +(fact3*theta);
temp = fact3*theta(1);
grad(1) = grad(1)-temp;



% =============================================================

end
