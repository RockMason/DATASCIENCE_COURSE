%%Am-FM Sinusoidal Signal
%Signal Parameters
A = 5;
b = 4;
f0 = 100;
f1 = 20;

% Signal Duration and Sampling
sigLen = 1;
samplIntrvl = 0.001;
timeVec = 0:samplIntrvl:sigLen ;
%Generate Signal
sigVec = amfmsigfunc(timeVec,A, b,[f0,f1]);
%Plot Signal
plot(timeVec,sigVec,'-')

%Plot of the Periodogram

dataLen = timeVec(end)-timeVec(1);
nSamples = length(timeVec);
%dft sample
dft=floor(nSamples/2)+1;

posFreq = (0:(dft-1))*(1/dataLen);
fftSig = fft(sigVec);
fftSig = fftSig(1:dft);
figure;
plot(posFreq,abs(fftSig));
xlabel('Frequency (Hz)');
ylabel('|FFT|');
title('Periodogram');