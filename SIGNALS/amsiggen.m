%%Amplitude Modulated Sinusoid Signal
%Signal Parameters
A = 5;
f0 = 2;
f1 = 8;
phi0 = 4; 

% Signal Duration and Sampling
sigLen = 1;
samplIntrvl = 0.001;
timeVec = 0:samplIntrvl:sigLen ;
%Generate Signal
sigVec = amsigfunc(timeVec,A, [f0,f1],phi0);
%Plot Signal
plot(timeVec,sigVec,'-')