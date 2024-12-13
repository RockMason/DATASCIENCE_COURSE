function sigVec= qcsigfuncNew(dataX,snr,params)
%Function Generates a quadratic chirp signal
%S=quadchirpsig(X,SNR,C)
%Signal X generated at time stamps denoted by vector X,
%SNR is the measure of Signal-to-Noise, and C are the coefficients of the
%of the phase equation that characterizes the signal
%a1*t+a2*t^2=a3*t^3

%Rock Mason, September 2024
phaseVec = params.a1*dataX + params.a2*dataX.^2 + params.a3*dataX.^3;
sigVec = sin(2*pi*phaseVec);
sigVec = snr*sigVec/norm(sigVec);