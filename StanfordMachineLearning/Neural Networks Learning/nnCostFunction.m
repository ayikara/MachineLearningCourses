function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

%First map the y values to vector with 0's and 1 where the image number is there... y =5 means (0,0,0,0,1,0,0,..0)
ylen = size(y,1);
ymap =zeros(size(y,1),num_labels);
for iter = 1 : ylen
	idx = y(iter);
	ymap(iter,idx) =1;
end




aOne =[ones(m,1) X];
zTwo = aOne*Theta1';
aTwo = sigmoid(zTwo);
aTwo = [ones(m,1) aTwo];


zThree =aTwo*Theta2';
aThree = sigmoid(zThree);


hXln = log(aThree);
fact1 = -1*ymap.*hXln;
fact2 = (1-ymap).*log(1-aThree);
jT = fact1 -fact2;
jT = eye(m)*jT; %%(-y2.*log(a3)-(1-y2).*log(1-a3)) will result in m*m matrix where m = 5000. Summing all the elements of this matrix will also include the extra terms (-y2j.*log(a3i)-(1-y2j).*log(1-a3i)). To remove these terms just multiply with eye(m) (identity matrix).
Jsub =sum(jT(:));
Jsub = Jsub/m;


% fprintf('\nSize of Theta2 row*: %d columns: %d\n', size(Theta2, 1),size(Theta2, 2));
% fprintf('\nSize of Theta1 row*: %d columns: %d\n', size(Theta1, 1),size(Theta1, 2));
%Regularized cost function

Theta1Reg = Theta1;
Theta2Reg = Theta2;
Theta1Reg(:,[1])=[];
Theta2Reg(:,[1])=[];

regfactor = (sumsq(Theta1Reg(:)) + sumsq(Theta2Reg(:)))*(lambda/(2*m));

J = Jsub + regfactor;

%Backpropagation

% aOne 
% zTwo 
% aTwo 
% aTwo
% ymap

% fprintf('\nSize of X m: %d\n', m);


% fprintf('\nSize of zTwo row: %d column: %d\n', size(zTwo, 1),size(zTwo, 2));


% fprintf('\nSize of Theta2 row ^: %d columns: %d\n', size(Theta2, 1),size(Theta2, 2));
% fprintf('\nSize of Theta1 row ^: %d columns: %d\n', size(Theta1, 1),size(Theta1, 2));



zThree =aTwo*Theta2';
aThree = sigmoid(zThree);
% fprintf('\nSize of aThree row: %d column: %d\n', size(aThree, 1),size(aThree, 2));
% fprintf('\nSize of zThree row: %d column: %d\n', size(zThree, 1),size(zThree, 2));


%deltaThree = zeros(m,1); % intitalize the delta vector
deltaThree = zeros(m,num_labels); % intitalize the delta vector


for iter = 1 : m
 
	%deltaThree(iter) = all(aThree(iter,:) == ymap(iter,:));
	%deltaThree(iter,:) = (aThree(iter,:) == ymap(iter,:));
	deltaThree(iter,:) = (aThree(iter,:) - ymap(iter,:));
	

end

gzTwo =  sigmoidGradient(zTwo);
% fprintf('\nSize of Theta2Reg row: %d column: %d\n', size(Theta2Reg, 1),size(Theta2Reg, 2));
% fprintf('\nSize of deltaThree row: %d column: %d\n', size(deltaThree, 1),size(deltaThree, 2));
% fprintf('\nSize of gzTwo row: %d column: %d\n', size(gzTwo, 1),size(gzTwo, 2));

deltaTwo = (deltaThree*Theta2Reg).*gzTwo; % Need to get the right row x col sizes

% fprintf('\nSize of deltaTwo row: %d column: %d\n', size(deltaTwo, 1),size(deltaTwo, 2));
% fprintf('\nSize of aOne row: %d column: %d\n', size(aOne, 1),size(aOne, 2));
% fprintf('\nSize of deltaThree row: %d column: %d\n', size(deltaThree, 1),size(deltaThree, 2));
% fprintf('\nSize of aTwo row: %d column: %d\n', size(aTwo, 1),size(aTwo, 2));
% fprintf('\nProgram paused before grad Calc. Press enter to continue.\n');
%pause;
%calculate the accumulated deltas
Theta1_grad = deltaTwo'*aOne;
Theta2_grad = deltaThree'*aTwo;
% fprintf('\nSize of Theta1_grad row: %d column: %d\n', size(Theta1_grad, 1),size(Theta1_grad, 2));
% fprintf('\nSize of Theta2_grad row: %d column: %d\n', size(Theta2_grad, 1),size(Theta2_grad, 2));
% fprintf('\nProgram paused after grad Calc. Press enter to continue.\n');
%pause;
Theta1_grad =(1/m).*Theta1_grad;
Theta2_grad =(1/m).*Theta2_grad;



% fprintf('\nSize of Theta1_grad row: %d column: %d\n', size(Theta1_grad, 1),size(Theta1_grad, 2));
% fprintf('\nSize of Theta2_grad row: %d column: %d\n', size(Theta2_grad, 1),size(Theta2_grad, 2));

% fprintf('\nSize of Theta1Reg row: %d column: %d\n', size(Theta1Reg, 1),size(Theta2Reg, 2));
% fprintf('\nSize of Theta2Reg row: %d column: %d\n', size(Theta2Reg, 1),size(Theta2Reg, 2));

% fprintf('\nSize of Theta1 row: %d column: %d\n', size(Theta1, 1),size(Theta2, 2));
% fprintf('\nSize of Theta2 row: %d column: %d\n', size(Theta2, 1),size(Theta2, 2));
% fprintf('\nProgram paused after grad Calc. Press enter to continue.\n');
% pause;

col1_grad1 = Theta1_grad(:,1);
col1_grad2 = Theta2_grad(:,1);

Theta1_grad = Theta1_grad .+ ((lambda/m).*Theta1);
Theta2_grad = Theta2_grad .+ ((lambda/m).*Theta2);
Theta1_grad(:,1) =col1_grad1;
Theta2_grad(:,1) =col1_grad2;




























% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
