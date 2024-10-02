%% Quadratic Chirp Signal Plot
%Signal Parameters
a1 = 10;
a2 = 4;
a3 = 2;
A =20;


% Signal Duration and Sampling
sigLen = 5;
samplIntrvl = 0.001;
timeVec = 0:samplIntrvl:sigLen ;


%Signal Generation
sigVec= qcsigfunc(timeVec,A,[a1,a2,a3]);



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