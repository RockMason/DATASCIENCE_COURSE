%% Linear Chirp

%Parameters
A = 10;
f0 = 2;
f1 = 0.1;
phi0 = 4;
%Signal Duration
sigLen = 2;
samplIntrvl = 0.01;
timeVec = 0:samplIntrvl:sigLen ;



sigVec = A * sin(2*pi*(f0*timeVec+f1*timeVec)+phi0);

%Plot of Signal in time domain
plot(timeVec,sigVec,'-*')