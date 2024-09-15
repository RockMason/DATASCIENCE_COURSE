function sigVec = ltcfunc(dataX,snr,ta,fCoef,phi0,L) 
%Function to generate Linear Transient Chirp using a conditional statement
if (ta<dataX) & (dataX<(ta+L))
    sigVec = sin(2*pi*(fCoef(0)*(dataX-ta)+fCoef(2)*(dataX-ta).^2)+phi0);
else 
    sigVec = 0;
end
sigVec = snr*sigVec/norm(sigVec);