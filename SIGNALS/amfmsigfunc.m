function sigVec= amfmsigfunc(dataX,snr,b,fCoef)
%Signal generator for an AM-FM Sinusoid

%Rock M. Mason, September 2024

am = cos(2*pi*fCoef(1)*dataX);
fm = sin(2*pi*fCoef(1)*dataX+b*cos(2*pi*fCoef(2)*dataX));
sigVec = am.*fm;
sigVec = snr*sigVec/norm(sigVec);