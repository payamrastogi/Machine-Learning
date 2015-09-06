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

%disp(size(Theta1));%25 401
%disp(size(Theta2));%10 26
%disp(m);%5000
%disp(num_labels);% 10
%disp(size(X));%5000 400
%disp(size(y));%5000 1

%Random Initialization
%Theta1 = rand(10, 11) * (2 * INIT_EPSILON) - INIT_EPSILON;
%Theta2 = rand(1, 11) * (2 * INIT_EPSILON) - INIT_EPSILON;

a1 = [ones(m,1) X];
%disp(size(a1));%5000 401
a2 = [ones(m,1) sigmoid(a1 * Theta1')]; % [5000 401][401 25] = [5000 25] biasing->[5000 26]
%disp(a2);
%disp(size(a2)); %5000 26
a3 = sigmoid(a2 * Theta2'); %[5000 26][26 10] -> [5000 10]
%disp(a3);
%y =
%   1
%   7
%   9
%   ...
%   8
yVector = repmat([1:num_labels], m, 1) == repmat(y, 1, num_labels);%element-wise comparison
%yVector =
%   [1 0 0 0 0 0 0 0 0 0]
%   [0 0 0 0 0 0 1 0 0 0]
%   [0 0 0 0 0 0 0 0 1 0]
%   ...
%   [0 0 0 0 0 0 0 1 0 0]
%disp(size(repmat([1:num_labels], m, 1)));%5000 10
%disp(size(repmat(y, 1, num_labels)));%5000 100
%disp(size(yVector));%5000 10
cost = -yVector.*log(a3) - (1-yVector).*log(1-a3);
cost = sum(sum(cost));
J = 1/m * cost;

%regularization of cost function
%removing bias term
Theta1WithoutBias = Theta1(:, 2:end);
Theta2WithoutBias = Theta2(:, 2:end);
%disp(size(Theta3));%25 400
%disp(size(Theta4));%10 25
temp1 = sum(sum(Theta1WithoutBias.^2)) + sum(sum(Theta2WithoutBias.^2));
reg = (lambda/(2*m))*temp1;
J = J + reg;

D1 = zeros(size(Theta1));
D2 = zeros(size(Theta2));

%a1(t,:)[401 1]
for t=1:m
    d3t = a3(t,:)' - yVector(t,:)'; % d3t[10 1]
%   disp(size(d3t))%d3t[10 1]
    z2t = [1, a1(t,:) * Theta1']; %[1 401][401 25] -> [1 25]
%   disp(size(z2t));[1 26]
    d2t = Theta2' * d3t .* sigmoidGradient(z2t'); %[26 10][10 1] ->[26 1].*[26 1] -> [26 1]
%    disp(size(d2t));[26 1]
    D1 = D1 + d2t(2:end) * a1(t, :); %[25 1][1 401]
    D2 = D2 + d3t * a2(t,:); %[10 1][26 1]
end;

Theta1ZeroBias = [ zeros(size(Theta1, 1), 1) Theta1WithoutBias ];
Theta2ZeroBias = [ zeros(size(Theta2, 1), 1) Theta2WithoutBias ];
Theta1_grad = (1 / m) * D1 + (lambda / m) * Theta1ZeroBias;
Theta2_grad = (1 / m) * D2 + (lambda / m) * Theta2ZeroBias;
% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
