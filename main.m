function [t,x,y,kalman_filtered,est_error_var,ls_filtered] = main(sigma_w, w, N)

% Simulation without acceleration
T = 1;
sigma_v = 1;

% initial state for model
x0 = [10;10];

% time axis
t = 1:T:N;

% state transition matrix
A = [1 T ; 0  1];

x = simulate_radar_model(T, w, A, x0);
y = simulate_radar_signal(x, sigma_v);

% display('Running Kalman');
[kalman_filtered, est_error_var] = radar_kalman(y, T, A, sigma_w);
% display('Running LS');
ls_depth = 2;
ls_filtered = [[0;0], ls_filter(x', y', ls_depth)];




