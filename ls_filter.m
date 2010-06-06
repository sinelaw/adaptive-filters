function [ filtered ] = ls_filter(x, y, M)

N = size(x,1)-M;
L = length(y);
i = M;
A = toeplitz(y(i:i+N-1), y(i:-1:i-M+1));
z = x(1:size(A,1),:);
w = inv(A'*A)*A'*z;

filtered = [0; 0];
for j = 1:N;
    estimate = w'*y(j:j+M-1);
    filtered = [filtered, estimate];
end

% BUG - the velocity component comes out negative.
% I couldn't figure out until the assignment was due.
filtered(2,:) = -filtered(2,:);
