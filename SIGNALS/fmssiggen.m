%%Frequency Modulated Sinusoid
%Signal Parameters
A = 5;
b = 4;
f0 = 100;
f1 = 4;

% Signal Duration and Sampling
sigLen = 10;
samplIntrvl = 0.001;
timeVec = 0:samplIntrvl:sigLen ;
%Generate Signal
sigVec = fmsgenfunc(timeVec,A,b, [f0,f1]);
%Plot Signal
plot(timeVec,sigVec,'-')
sound(sigVec)