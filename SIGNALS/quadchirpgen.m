%% Quadratic Chirp Signal Plot
%Signal Parameters
a1 = 10;
a2 = 5;
a3 = 5;
A =20;


% Signal Duration and Sampling
sigLen = 1;
samplIntrvl = 0.001;
timeVec = 0:samplIntrvl:sigLen ;


%Signal Generation
sigVec= qcsigfunc(timeVec,A,[a1,a2,a3]);



%Plot of Signal in time domain
plot(timeVec,sigVec,'-')