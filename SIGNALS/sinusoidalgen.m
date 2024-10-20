%% Sinusoidal Signal
%Signal Parameters
phi0 = 10;
f0 = 244;
A =20;

% Signal Duration

sigLen = 10;
samplIntrvl = 0.01;
timeVec = 0:samplIntrvl:sigLen ;

%  Signal function

sigVec = sinsigfunc(timeVec,A,f0,phi0);

%Plot of Signal in time domain
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