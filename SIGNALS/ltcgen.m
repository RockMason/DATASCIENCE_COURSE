%%Linear Transient Chirp Signal

%Parameters
A = 5;
ta = 3;
f0 = 3;
f1 = 5;
phi0 = 2;


% Signal Duration and Sampling
sigLen = 10;
samplIntrvl = 0.01;
timeVec = 0:samplIntrvl:sigLen;
L = timeVec(301:401);

%Generate Signal
sigVec = ltcfunc(L,A,ta,[f0,f1],phi0);

%Plot Signal
plot(timeVec,sigVec,'-')