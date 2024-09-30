function sigVec = ltcfunc(dataX,snr,ta,fCoef,phi0) 
%Function to generate Linear Transient Chirp using a conditional statement

sigVec = sin(2*pi*(fCoef(0)*(dataX-ta)+fCoef(2)*(dataX-ta).^2)+phi0);

sigVec = snr*sigVec/norm(sigVec);