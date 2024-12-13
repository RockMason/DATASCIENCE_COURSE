%% PSO LAB TASK 2
addpath SIGNALS\
%Script that creates a function handle and passes through a parameter
%strucutre and a data set dataX

dataX = (0:499)/1024;
b = 4;
f0 = 100;
f1 = 4;
SNR = [10; 12; 15];
x = SNR;
P =  struct('b',b, 'f0', f0, 'f1', f1);

H = @(x) fmsgenfunc2(dataX, x, P);

plot(dataX,H(x))
xlabel('Time (s)')
ylabel('H')
legend(compose('SNR = %.1f',x), 'Location','best')