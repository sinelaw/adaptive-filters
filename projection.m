function p = projection(X, y)
% projection: projects a vector onto a subspace defined by vectors in C^n
% X - an n x m matrix where the columns are vectors that define the subspace
% y - the (n x 1) vector we want to project into the subspace
% p - the (n x 1) result, is the projection of y onto X

[n,m] = size(X);
s = min(m,n);
assert(n == length(y), 'y must be a column vector with the same length as each column of X');

% error margin for near-zero values
delta = 1e-10;

A = X;
V = A'; 
A2 = V*A; % m x m matrix

% The equation is: A'*y = A'*A*z where z is an (m x 1) vector and p = A*z

% We must solve for z
% To solve in the general case we use Gaussian elimination
elimMat = [A2 , V*y];
for i = 1:m
    topRow = elimMat(i,:);
    v = topRow(i);
    if (abs(v) < delta) 
        continue
    end
    for rowNum = (i+1):m
        row = elimMat(rowNum,:);
        elimFactor = row(i) / v;
        elimMat(rowNum,:) = row - elimFactor*topRow;
    end
end
% Find the solution from the eliminated matrix | vector combination:
% We should have an s x s sized subset that has no zero rows or columns
% We use it to calculate z (by skipping zeros). This way we deal with all cases n<m, m>=n, or <m indepdent, etc...
B = elimMat(:,1:m);
elimVec = elimMat(:,m+1);
z = zeros(m,1);
for i = s:-1:1
    v = B(i,i);
    if (abs(v) < delta)
        % Matrix has less rank than rows, but we don't need a single solution
        % for z to find the solution p. So just pick 0 (already in z(i,:)).
        continue;
    end
    psum = sum(B(i,i+1:m) * z(i+1:m,:));
    z(i,:) = (elimVec(i) - psum) / v;
end

p = A*z;