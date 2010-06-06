function draw_results(t, x, y, filtered, e, est_error_var, ls_filtered)

ls_error = (x-ls_filtered).^2;
rows=3;
cols=4;

subplot(rows,cols,1);
plot(t, x(1,:));
ylabel('Model (position)');

subplot(rows,cols,2);
plot(t,x(2,:));
ylabel('Model (velocity)');

subplot(rows,cols,3);
plot(t, y);
ylabel('Measured position');

%subplot(rows,cols,4);
%plot(t,x(2,:));
%ylabel('Noiseless position');

subplot(rows,cols,5);
plot(t, filtered(1,:));
ylabel('Est. position');

subplot(rows,cols,6);
plot(t, filtered(2,:));
ylabel('Est. velocity');

subplot(rows,cols,7);
semilogy(t, e(1,:), '--b', t, est_error_var(1,:), '-r',t, ls_error(1,:), ':g', t, y, '-.c');
ylabel('Error - position');
legend('Kalman','Kalman (estimated)','LS', 'measured');

subplot(rows,cols,8);
semilogy(t, e(2,:), '--b', t, est_error_var(2,:), '-r', t,ls_error(2,:), ':g');
ylabel('Error - velocity');
legend('Kalman','Kalman (estimated)','LS', 'measured');

subplot(rows,cols,9);
plot(t,x(1,:), '--b', t,filtered(1,:), '-r', t,ls_filtered(1,:), ':g');
ylabel('Position (all)');
legend('model','Kalman','LS');

subplot(rows,cols,10);
plot(t,x(2,:), '--b', t,filtered(2,:), '-r', t,ls_filtered(2,:), ':g');
ylabel('Velocity (all)');
legend('model','Kalman','LS');

subplot(rows,cols,11);
plot(ls_filtered(1,:));
ylabel('LS - position');

subplot(rows,cols,12);
plot(ls_filtered(2,:));
ylabel('LS - velocity');


end

