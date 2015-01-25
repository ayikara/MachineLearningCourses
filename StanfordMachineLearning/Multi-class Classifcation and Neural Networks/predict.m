function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%
fprintf('\nSize of X m: %d\n', m);
fprintf('\nSize of Theta2 row: %d columns: %d\n', num_labels,size(Theta2, 2));
fprintf('\nSize of Theta1 num_labels: %d columns: %d\n', size(Theta1, 1),size(Theta1, 2));

aOne =[ones(m,1) X];
zTwo = aOne*Theta1';
aTwo = sigmoid(zTwo);
aTwo = [ones(m,1) aTwo];

fprintf('\nSize of aTwo row: %d column: %d\n', size(aTwo, 1),size(aTwo, 2));
zThree =aTwo*Theta2';
aThree = sigmoid(zThree);
fprintf('\nSize of aThree row: %d column: %d\n', size(aThree, 1),size(aThree, 2));
%p= max(aThree,[],2);
%fprintf('\nSize of p row: %d column: %d\n', size(p, 1),size(p, 2));

[w,iw] =max(aThree');
p =iw'; %again tranpose back
%fprintf('\nSize of p2 row: %d column: %d\n', size(p2, 1),size(p2, 2));











% =========================================================================


end
