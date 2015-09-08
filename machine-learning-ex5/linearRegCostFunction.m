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

%disp(size(theta));%[2 1]
%disp(size(X)); %[12 2]
%disp(size(y)); %[12 1]
%disp(size(lambda)); %[1 1]
h = X * theta; %[12 2] * [2 1] [12 1]
temp1 = (h - y).^2;
temp2 = sum(temp1);
temp3 = temp2 * 0.5 * (1/m);

temp4 =  theta;
%do not regularize zeroth term of theta
temp4(1,1) = 0;
temp41 = temp4.^2;
reg = lambda * 0.5 * (1/m) * sum(temp41);

J = temp3 + reg;

temp5 = h - y; %[12 1]
temp6 = X' * temp5; % [2 12][12 1] -> [2 1]
temp7 = temp6 * (1/m);

temp8 = theta;
%do not regularize zeroth term of theta
temp8(1,1) = 0;

temp9 = lambda * (1/m) * temp8;

grad = temp7 + temp9;




% =========================================================================

grad = grad(:);

end
