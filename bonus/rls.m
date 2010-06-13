function [ y, w ] = rls( U, d, Pinitial, lambda, wInitial)

M = size(U,1);
N = size(U,2);

if (nargin < 5) 
    wInitial = zeros(1,M);
end

maxIterations = 100;

lambdaInv = lambda^-1;

P = Piniitial;
w = [wInitial];
wCur = wInitial;
for i = 1 : maxIterations
    alpha = lambdaInv * P * u;
    k = alpha ./ (1 + U'*alpha);
    e = d - wCur'*U;
    wNext = wCur + k*e';
    w = [w, wNext];
    if norm(wNext - wCur) < stopError
        return
    end
    P = lambdaInv * (P - k*U'*P);
    wCur = wNext;
end

y = w(:,size(w,2))'*U;

end

