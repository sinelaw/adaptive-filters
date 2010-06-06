function [ filtered ] = ls_filter(x, y, M)

N = size(x,1);
L = length(y);
i = L-N;
A = toeplitz(y(i:i+N-1), y(i:-1:i-M+1));
w = inv(A'*A)*A'*x;

filtered = [0; 0];
for j = 1:L-M
    estimate = w'*y(j:j+M-1);
    filtered = [filtered, estimate];
end

%filtered = zeros(size(x,1),size(x,2));
%for i = 1 : min(M,(L-N+1))
    %samples = y(i:i+N-1)
    %filtered(:,i) = WH*samples;
%end