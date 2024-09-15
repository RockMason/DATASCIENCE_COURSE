function sigVec=lcsigfunc(dataX,snr,lcCoef, phi0)

phaseVec = lcCoef(1)*dataX+lcCoef(2)*dataX.^2;
sigVec =  sin(2*pi*(phaseVec)+phi0);
sigVec = snr*sigVec/norm(sigVec);