function sigVec=amsigfunc(dataX,snr,amCoef,phi0)
%Signal generator for an amplitude modulated sinusoidal function

%Rock M. Mason, September 2024

sigVec = cos(2*pi*amCoef(2)*dataX).*sin(amCoef(1)*dataX+phi0);
sigVec = snr*sigVec/norm(sigVec);