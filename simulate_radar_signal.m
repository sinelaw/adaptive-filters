function y = simulate_radar_signal(x, sigma_v)

v = random('Normal', 0, sigma_v, length(x), 1)';
y = x(1,:) + v;
