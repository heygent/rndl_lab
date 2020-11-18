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
        x = X(:, k);
        y = Y(:, k);
        % Modifica di W_hid e W_out.
        % a_hid e a_out sono le attivazioni del layer nascosto e di output.
        a_hid = f(W_hid * x);
        a_out = f(W_out * a_hid);
        delta_out = (y - a_out) .* f_grad(a_out);
        E = delta_out' * W_out;
        W_out = W_out + delta_out * a_hid';

        delta_hid = learning_rate * E' .* f_grad(a_hid);
        W_hid = W_hid + delta_hid * x';
    end
end
Y_hat=Y_hat';
