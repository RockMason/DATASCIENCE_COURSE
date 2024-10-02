%%Linear Transient Chirp Signal

%Parameters
A = 5;
ta = 3;
f0 = 100;
f1 = 20;
phi0 = 10;
L=1;

% Signal Duration and Sampling
sigLen = 20;
samplIntrvl = 0.01;
timeVec = 0:samplIntrvl:sigLen;
L = (ta+L)/samplIntrvl;

%Generate Signal
sigVec = 0;
sigVec(L) = ltcfunc(timeVec,A,ta,[f0,f1],phi0);
%Plot Signal
plot(timeVec,sigVec,'-')