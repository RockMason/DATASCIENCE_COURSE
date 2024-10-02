%%Sine-Gaussian Signal
%Signal Parameters
A = 5;
t0 = 1;
sigma = 1;
f0 = 100;
phi0 = 10; 

% Signal Duration and Sampling
sigLen = 1;
samplIntrvl = 0.001;
timeVec = 0:samplIntrvl:sigLen ;
%Generate Signal
sigVec = sgsigfunc(timeVec,A,t0,sigma,f0,phi0);
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