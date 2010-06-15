function question3()

load('mixedSignals1.mat');

filter_order = 16;
Fs = 16000;
window_size = 100;
U = toeplitz([x1(1) zeros(1,filter_order-1)],x1);
d = x2;

display('LS');
% Part A: LS filtering
%[y,w] = ls(U, d');
%soundsc(y'-x2,Fs);
%display('Weights:');
%display(w);

display('RLS');
% Part B: RLS filtering
Pinitial = 100*eye(filter_order);
lambdas = [0.05, 0.5, 0.85, 1];

lines = ['-', ':', '-.', '--'];
colors = ['b', 'g', 'r', 'c'];
i = 1;
for lambda = [1] %lambdas
    [y, w] = rls(U, d, Pinitial, lambda);
    
    subplot(2,2,i);
    plot(w(1,:), strcat(colors(i), lines(i)));
    title(['Weight changes during iterations of RLS filter with lambda = ', num2str(lambda)]);
    xlabel('Sample number');
    ylabel('w[0]');
    i = i + 1;
    soundsc(y'-x2,Fs);
end
hold off;

display('Wiener');
% Part C: Wiener filtering
R = cov_estimator(U,U);
p = cov_estimator(U,d');
[y,w] = weiner(U,R,p,false);
soundsc(y' - x2, Fs);

end


    
function [ R ] = cov_estimator(U,y)
% The biased corellation (or covariance) estimator
% U = MxN Matrix of first signal (toeplitz matrix), where each column n
%     is an M-length vector x(n:n-M+1)
% y = any-by-N matrix, second signal
    R = 1/size(U,2) * U * y';
end
