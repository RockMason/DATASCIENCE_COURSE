%%Sine-Gaussian Signal
%Signal Parameters
A = 5;
t0 = 1;
sigma = 2;
f0 = 10;
phi0 = 2; 

% Signal Duration and Sampling
sigLen = 1;
samplIntrvl = 0.001;
timeVec = 0:samplIntrvl:sigLen ;
%Generate Signal
sigVec = sgsigfunc(timeVec,A,t0,sigma,f0,phi0);
%Plot Signal
plot(timeVec,sigVec,'-')