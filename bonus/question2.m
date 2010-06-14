function question2()

% Print the weights for a filter of order 5
r5 = y_autocorellation_vector(0,4)
R5 = toeplitz(r5);

p5 = y_autocorellation_vector(1,5);
w5 = R5 \ p5;
display('Weights for filter of order 5:');
display(w5);


% Create a 400 sample input 
L = 400;
x = randn(L,1);
b = [1,-0.1];
a = [-0.4];
y = filter(b, a, x);

subplot(2,3,1);
plot(y);
subplot(2,3,2);
plot(x);
i = 3;
for filter_order = [1,2,5,15]
    % Build input matrices
    [ U, N ] = input_matrix(y, filter_order);
    r = y_autocorellation_vector(0,filter_order-1);    
    R = toeplitz(r);
    p = y_autocorellation_vector(1,filter_order);

    % Perform filtering
    [z, w] = weiner(U, R, p, false);
    
    % calculate error
    y_trunc = y(filter_order:length(y)-1, :);
    e = abs(z' - y_trunc).^2;
    % plot
    subplot(2,3,i);
    hold off;
    plot(z);
    hold on;
    plot(y_trunc, 'r');
    hold off;
    i = i + 1;
end

end

function [ U, N ] = input_matrix(y, filter_order)
    M = filter_order;
    N = length(y) - M;
    U = [];
    for i = 1 : N
        U = [U, y(i+M-1:-1:i)];
    end
end

function [ p ] = y_autocorellation_vector(start, stop)
    p = arrayfun(@(x) y_autocorellation(x), (start:stop)');
end

function [ r ] = y_autocorellation(l)
    a1 = 0.4;
    b1 = -0.1;

    r0 = (1 + (a1 + b1)^2) / (1 - a1^2);
    if (l == 0)
        r = r0;
    else
        r = a1^l * r0 + b1 * a1^(l-1);
    end
end