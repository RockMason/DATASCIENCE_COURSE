function sigVec= qcsigfunc(dataX,snr,qcCoef)
%Function Generates a quadratic chirp signal
%S=quadchirpsig(X,SNR,C)
%Signal X generated at time stamps denoted by vector X,
%SNR is the measure of Signal-to-Noise, and C are the coefficients of the
%of the phase equation that characterizes the signal
%a1*t+a2*t^2=a3*t^3

%Rock Mason, September 2024
phaseVec = qcCoef(1)*dataX + qcCoef(2)*dataX.^2 + qcCoef(3)*dataX.^3;
sigVec = sin(2*pi*phaseVec);
sigVec = snr*sigVec/norm(sigVec);