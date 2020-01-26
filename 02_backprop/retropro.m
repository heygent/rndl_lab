function [W_hid, W_out, Y_hat, error_history, iterations] = ...
  retropro(X, Y, hidden_size, learning_rate, error_threshold, max_iterations);


[dataset_rows, input_size] = size(X);
output_size = size(Y, 2);

if dataset_rows ~= size(Y, 1)
    error('Dimensionamento non corretto\n\n');
end

% Inizializzazione random dei pesi
W_hid = (rand(hidden_size, input_size) - 0.5) * 2;
W_out = (rand(output_size, hidden_size) - 0.5) * 2;

X = X';
Y = Y';
output_elem_count = dataset_rows * output_size;
error_history = [];


for iterations = 1:max_iterations

    Y_hat = f(W_out * f(W_hid * X));
    current_error = sum(sum(((Y_hat-Y).^2))) / output_elem_count;

    error_history = [error_history current_error];

    if current_error <= error_threshold
        break
    end
    
    for k=1:dataset_rows
        % Modifica di W_hid e B.
        Y_hid = f(W_hid * X(:, k));
        Y_out=f(W_out*Y_hid);
        DOut=(Y(:,k) - Y_out) .* Y_out .* (1-Y_out);
        E=DOut' * W_out;
        W_out = W_out + DOut * Y_hid';
        DYhid=learning_rate*E'.* Y_hid .*(1-Y_hid);
        W_hid=W_hid+DYhid*X(:,k)';
    end
end
Y_hat=Y_hat';
