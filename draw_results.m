function draw_results(t, x, y, filtered, e, est_error_var, ls_filtered)

rows=4;
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

subplot(rows,cols,4);
%plot(t,x(2,:));
%ylabel('Noiseless position');

subplot(rows,cols,5);
plot(t, filtered(1,:));
ylabel('Est. position');

subplot(rows,cols,6);
plot(t, filtered(2,:));
ylabel('Est. velocity');

subplot(rows,cols,7);
plot(t, e(1,:));
ylabel('Error - position');

subplot(rows,cols,8);
plot(t, e(2,:));
ylabel('Error - velocity');

subplot(rows,cols,9);
plot(t, est_error_var(1,:));
ylabel('Est. Error - position');

subplot(rows,cols,10);
plot(t, est_error_var(2,:));
ylabel('Est. Error - velocity');


subplot(rows,cols,13);
plot(ls_filtered(1,:));
ylabel('LS - position');

subplot(rows,cols,14);
plot(ls_filtered(2,:));
ylabel('LS - velocity');




end

