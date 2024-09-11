%% Quadratic Chirp Signal Plot
%Signal Parameters
a1 = 10;
a2 = 5;
a3 = 5;
A =20;


% Signal Duration
sigLen = 1;
samplIntrvl = 0.01;
timeVec = 0:samplIntrvl:sigLen ;

% Phase Vector for Signal and Signal function
phaseVec = a1*timeVec + a2*timeVec.^2 + a3*timeVec.^3;

sigVec = A * sin(2*pi*phaseVec);

%Plot of Signal in time domain
plot(timeVec,sigVec,'-*')