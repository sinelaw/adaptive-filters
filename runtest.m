clear all;

error_tests = 500;
N = 200;

% calculate LS weight matrix
%LS_N = N/2;
%Y = [ones(LS_N,1) (0:LS_N-1)'];
%WH = Y'*inv(Y*Y');
% --------------------

sigma_w = 0;
w = zeros(N,1); %random('Normal', 0, sigma_w, N, 1)';
e = 0;
for i = 1:error_tests
    [t,x,y,filtered,est_error_var,ls_filtered] = main(sigma_w, w, N);
    e = e + (x - filtered).^2;
end
e = e ./ error_tests;
newplot;
draw_results(t,x,y,filtered,e,est_error_var,ls_filtered);

sigma_w = 1;
e = 0;
for i = 1:error_tests
    w = random('Normal', 0, sigma_w, N, 1)';
    [t,x,y,filtered,est_error_var,ls_filtered] = main(sigma_w, w, N);
    e = e + (x - filtered).^2;
end
e = e ./ error_tests;
figure;
draw_results(t,x,y,filtered,e,est_error_var,ls_filtered);


sigma_w = 0.001;
w = 0.01*ones(N, 1);
e = 0;
for i = 1:error_tests
    w = random('Normal', 0, sigma_w, N, 1)';
    [t,x,y,filtered,est_error_var,ls_filtered] = main(sigma_w, w, N);
    e = e + (x - filtered).^2;
end
e = e ./ error_tests;
figure;
draw_results(t,x,y,filtered,e,est_error_var,ls_filtered);
