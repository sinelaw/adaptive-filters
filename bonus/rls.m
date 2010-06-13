function [ y, w ] = rls( U, d, Pinitial, lambda, wInitial)

M = size(U,1);
N = size(U,2);

if (nargin < 5) 
    wInitial = zeros(M,1);
end

lambdaInv = lambda^-1;

P = Pinitial;
w = [wInitial];
wCur = wInitial;
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

