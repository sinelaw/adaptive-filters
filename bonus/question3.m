function question3()

load('mixedSignals1.mat');

filter_order = 16;
window_size = 100;
U=toeplitz([x1(1) zeros(1,filter_order-1)],x1);
% Part A: LS filtering
d = x2;
[y,w] = ls(U, d');
soundsc(y'-x2,16000);
display('Weights:');
display(w);
