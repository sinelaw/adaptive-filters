function question2()

% Print the weights for a filter of order 5
r5 = y_autocorellation_vector(0,4);
R5 = toeplitz(r5);

p5 = y_autocorellation_vector(1,5);
w5 = R5 \ p5;
display('Weights for filter of order 5:');
display(w5);


% Create a 400 sample random, white input 
L = 400;
x = randn(L,1);

% Filter it through the given system
b = [1,-0.1];
a = [1,-0.4];
y = filter(b, a, x);

i = 1;

mse_vec = [];
orders = [1,2,5,15];
% Estimate y[n] using previous samples of y using the Weiner filter
% use different FIR orders for comparison
for filter_order = orders
    % Build input matrices
    %[ U, N ] = input_matrix(y, filter_order);
    u = y';
    U = toeplitz(zeros(1,filter_order),[0 u(1:end-1)]);
    r = y_autocorellation_vector(0,filter_order-1);    
    R = toeplitz(r);

    % "cross-corellation" between y[n] and previous samples
    p = y_autocorellation_vector(1,filter_order);

    % Perform filtering
    [z, w] = weiner(U, R, p, false);
    
    % calculate error
    e = abs(z' - y).^2; % Square error
    mse = mean(e); % Mean square error
    
    mse_vec = [mse_vec, mse];
    % plot
    subplot(2,3,i);
    stem(e, 'marker', 'none');
	title(['Error for filter of order ', num2str(filter_order), ', MSE = ', num2str(mse)]);
    ylabel('e^2[n]');
    xlabel('n');
    i = i + 1;
end

subplot(2,3,i);
plot(orders, mse_vec);
title('Mean square error per filter order');
xlabel('Filter order');
ylabel('MSE');

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