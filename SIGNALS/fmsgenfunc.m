function sigVec = fmsgenfunc(dataX,snr, b, fmCoef)
%Signal generator for a Frequency modulated sinusoidal signal

%Rock M. Mason, September 2024
sigVec = sin(2*pi*fmCoef(1)*dataX+b*cos(2*pi*fmCoef(2)*dataX));
sigVec= snr*sigVec/norm(sigVec);