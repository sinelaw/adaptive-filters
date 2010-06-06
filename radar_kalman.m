function [est_state, est_error_var] = radar_kalman(y, T, A, sigma_w, x0)

N = length(y);

H = [1 0];
Q = [T^4/4  T^3/2; T^3/2  T^2] * sigma_w;
R = 1;
C = 0;

% initial covariance estimation
P0 = sigma_w*diag([100,100]);
K0 = calc_k(P0,A,R,H,C);

% intialize state estimation to zero
x = x0;
K = K0;
P = P0;
est_error_var = zeros(2,N);
% perform estimation
for i = 1 : N-1 ;
    x(:,i+1) = A*x(:,i)+K*(y(i) - H*x(:,i));
    P = calc_p(P, K, A, R, H, Q);
    K = calc_k(P,A,R,H,C);
    est_error_var(:,i) = diag(P);
end

est_state = x;

end

function resP = calc_p(prev_p, prev_k,A,R,H,Q)
resP = A*prev_p*A' - prev_k*(R+H*prev_p*H')*prev_k' + Q;
end

% calculates K[k] given P[k]
function resK = calc_k(P,A,R,H,C)
resK = A*(P*H'+C)*inv(R + H*P*H');
end