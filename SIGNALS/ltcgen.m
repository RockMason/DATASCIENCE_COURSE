%%Linear Transient Chirp Signal

%Parameters
A = 5;
ta = 1;
f0 = 3;
f1 = 5;
phi0 = 2;
L = 1;

% Signal Duration and Sampling
sigLen = 1;
samplIntrvl = 0.001;
timeVec = 0:samplIntrvl:sigLen;

%Generate Signal
sigVec = ltcfunc(timeVec,A,ta,[f0,f1],phi0,L);

%Plot Signal
plot(timeVec,sigVec,'-')