function r = simulate_radar_model(T, w, A, x0)

N = length(w);
% w = N samples of model noise

% initial state
r = x0;


% noise is multiplied by this vector at each step
u = [T^2/2; T];

for i = 1 : N-1;
    next_r = A*r(:,i)+u*w(i);
    r = [r, next_r];
end

