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
%disp(size(theta)); %28 1
%disp(size(X)); %118 28
%disp(size(y)); %118 1
%disp(size(lambda));%1 1

H = sigmoid(X * theta);
T1 = log(H);
T2 = log(1-H);
T3 = -y' * T1;
T4 = (1-y') * T2;
S = T3 - T4;


regTheta = theta(2:size(theta,1), 1);
%disp(size(regTheta));%27 1
T5 = regTheta.^2;
%disp(size(T5));%27 1
T6 = sum(T5);
%disp(size(T6));%1 1

J = S * (1/m) + (lambda/(2*m))*T6;

A = theta;
A(1,1) = 0;
%disp(size(A));
T7 = H - y;
T8 = T7' * X;
grad = T8'.*(1/m) + A.* (lambda/m);

% =============================================================

end
