function [ y, w ] = rls( U, d, Pinitial, lambda, wInitial)
% RLS Filter
% -------------
% Inputs:
% U = MxN input matrix, where each column n is a vector u[n]...u[n-M] of input
% samples
% d = N-length row vector, reference signal 
% Pinitial = initial variance estimation matrix, 
% lambda = memory coefficient
% wInitial = initial weights
% -------------
% Outputs:
% y = filtered data
% w = MxN matrix where each column is a weight vector corresponding to one
% iteration of the RLS


M = size(U,1);
N = size(U,2);

if (nargin < 5) 
    wInitial = zeros(M,1);
end

lambdaInv = lambda^-1;

P = Pinitial;
w = [wInitial];
wCur = wInitial;
% Perform the iterations
for i = 1 : N
    u = U(:,i);
    alpha = lambdaInv * P * u;
    k = alpha ./ (1 + u'*alpha);
    e = d(i) - wCur'*u;
    wNext = wCur + k*e';
    w = [w, wNext];
    P = lambdaInv * (P - k*u'*P);
    wCur = wNext;
end

y = w(:,size(w,2))'*U;

end

