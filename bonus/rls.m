function [ y, w ] = rls( U, d, Pinitial, lambda, wInitial)
% RLS Filter
% -------------
% Inputs:
% U = MxN input matrix, where each column n is a vector u[n]...u[n-M] of input
%     samples, M is the filter order.
% d = N-length row vector, reference signal 
% Pinitial = MxM initial variance estimation matrix, 
% lambda = memory coefficient
% wInitial = M-length column vector, of initial weights. If not supplied,
%            defaults to 0
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
w = zeros(M,N);
wCur = wInitial;
% Perform the iterations
for i = 1 : N
    u = U(:,i);
    alpha = lambdaInv * P * u;
    k = alpha ./ (1 + u'*alpha);
    e = d(i) - wCur'*u;
    wNext = wCur + k*e';
    P = lambdaInv * (P - k*u'*P);
    w(:,i) = wCur;
    wCur = wNext;
end

y = w(:,size(w,2))'*U;

end

