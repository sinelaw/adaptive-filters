function [ U, N ] = input_matrix(y, filter_order)
    M = filter_order;
    N = length(y) - M;
    U = [];
    for i = 1 : N
        U = [U, y(i+M-1:-1:i)];
    end
end
