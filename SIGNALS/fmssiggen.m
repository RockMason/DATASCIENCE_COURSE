%%Frequency Modulated Sinusoid
%Signal Parameters
A = 5;
b = 4;
f0 = 4;
f1 = 10;

% Signal Duration and Sampling
sigLen = 1;
samplIntrvl = 0.001;
timeVec = 0:samplIntrvl:sigLen ;
%Generate Signal
sigVec = fmsgen(timeVec,A,b, [f0,f1]);
%Plot Signal
plot(timeVec,sigVec,'-')