function [ y, w ] = weiner(U, R, p, SD, stop, initial)

M = size(U,1);
N = size(U,2);

if (~SD)
    % Don't use steepest descent, invert the matrix directly.
    
    error(nargchk(4,4, nargin));
    
    if (det(R) > 0) 
        w = R \ p;
    else
        w = (R'*R) \ (R' * p);
    end
   
    y = w' * U;
    
    return;
end


% Do the steepest descent method

error(nargchk(5,6,nargin));

maxIterations = stop(1);
stopCondition = stop(2);
lambda_max = max(eig(R));
mu = (2 / lambda_max) / 2;

if (nargin == 5) 
    initial = zeros(M,1);
end

i = 0;
wCur = initial;
w = [initial];
for i = 1 : maxIterations
    wNext = wCur - mu*(R*wCur - p);
    w = [w, wNext];
    if (norm(wNext - wCur) < stopCondition)
        break;
    end
    wCur = wNext;
end

y = w(:,size(w,2))'*U;

end
    




