function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

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
%
% Note: grad should have the same dimensions as theta
%
fact = 1/(m);

temp1 = X*theta; %this is Theta transform times X

tempH = sigmoid(temp1);
logH = log(tempH);
log1mH =log(1 - tempH);

tempJT1 = -1 * y.*logH; % The first term of the J(theta) calculation .. Need to use the element wise multiplication
tempJT2 = (1 - y).*log1mH;  %second term of the J(theta) calculation

tempJTheta = tempJT1 - tempJT2; %terms inside the summation
J = fact*sum(tempJTheta); %1/m x y.log(h) - (1-y).log(1-h);




%---------Cal gradient of cost ----------

temphy1 = tempH - y; % term inside the Summation of grad calc
temphy1 = temphy1*(1/m);


grad =(temphy1'*X);






% =============================================================

end
