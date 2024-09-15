function sigVec = sinsigfunc(dataX, snr, f0, phi0)
%Function that generates sinusoidal signal. dataX is time vector,
%snr is the amplitude, f0 is the initial frequency, and phi0 is an initial
%phase shift

% Rock A. Mason, September 2024
sigVec = sin(2*pi*f0*dataX+phi0);
sigVec= snr*sigVec/norm(sigVec);