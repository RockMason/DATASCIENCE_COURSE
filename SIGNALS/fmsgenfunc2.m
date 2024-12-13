function sigVec = fmsgenfunc2(dataX,snr, P)
%Signal generator for a Frequency modulated sinusoidal signal
b = P.b;
f0 = P.f0;
f1 = P.f1;


%Rock M. Mason, September 2024
sigVec = sin(2*pi*f0*dataX+b*cos(2*pi*f1*dataX));
sigVec= snr*sigVec/norm(sigVec);