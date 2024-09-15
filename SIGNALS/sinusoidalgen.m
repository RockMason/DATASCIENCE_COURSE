%% Sinusoidal Signal
%Signal Parameters
phi0 = 10;
f0 = 5;
A =20;

% Signal Duration
sigLen = 1;
samplIntrvl = 0.01;
timeVec = 0:samplIntrvl:sigLen ;

%  Signal function

sigVec = sinsigfunc(timeVec,A,f0,phi0);

%Plot of Signal in time domain
plot(timeVec,sigVec,'-')