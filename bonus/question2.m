function question2()

% Print the weights for a filter of order 5
p5 = y_autocorellation_vector(5);
R5 = toeplitz(p5);
w5 = R5 / p5;
display('Weights for filter of order 5:');
display(w5);


% Create a 400 sample input 
L = 400;
x = rand(L,1);
b = [1,-0.1];
a = [-0.4];
y = filter(b, a, x);

i = 1;
for filter_order = [1,2,5,15]
    % Build input matrices
    [ U, N ] = input_matrix(y, filter_order);
    p = y_autocorellation_vector(filter_order);
    R = toeplitz(p);
    
    % Perform filtering
    [z, w] = weiner(U, R, p, false);
    
    % calculate error
    size(z)
    size(y)
    e = abs(z - y).^2
    
    % plot
    subplot(2,3,i);
    plot(e);
    i = i + 1;
end

end

function [ U, N ] = input_matrix(y, filter_order)
    M = filter_order;
    N = length(y) - M;
    U = [];
    for i = 1 : N
        U = [U, y(i+M:-1:i)];
    end
end

function [ p ] = y_autocorellation_vector(length)
    p = arrayfun(@(x) y_autocorellation(x), 1:length);
end

function [ r ] = y_autocorellation(l)
    a1 = 0.4;
    b1 = -0.1;

    r0 = (1 + (a1 + b1)^2) / (1 - a1^2);

    r = a1^l * r0 + b1 * a1^(l-1);

end