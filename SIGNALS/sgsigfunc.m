function sigVec = sgsigfunc(dataX,snr,t0,sigma,f0,phi0)
%Function to generate Sine-Gaussian Signal

%Rock M. Mason, September 2024
gauss = exp(-(dataX-t0).^2/(2*sigma));
sigVec = gauss.*sin(2*pi*f0*dataX+phi0);
sigVec = snr*sigVec/norm(sigVec);