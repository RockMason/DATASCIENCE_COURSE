%% Quadratic Chirp Signal Plot
clear
close all
%Signal Parameters
a1 = 10;
a2 = 3;
a3 = 10;
A =10;

sigLen = 1;
%Instantaneous Frequency after sigLen
maxFreq = a1+2*a2*sigLen+3*a3*sigLen.^2;
%Nyquist Frequency
nyqFreq = 2*maxFreq;

%Sampling
sampleFreq = 2*nyqFreq;
sampleIntrvl = 1/sampleFreq;

%Signal Duration


timeVec = 0:sampleIntrvl:sigLen;

%nSamples for periodogram
nSamples = length(timeVec);


%Signal Generation
sigVec= qcsigfunc(timeVec,A,[a1,a2,a3]);



%Plot of Signal in time domain
plot(timeVec,sigVec,'-');
xlabel('Duration (s)');
ylabel('Power');

%Plot of the Periodogram
dataLen = timeVec(end)-timeVec(1);
%dft sample
kNyq=floor(nSamples/2)+1;
%Identify positive frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);

fftSig = fft(sigVec);
%Discarding Negative Frequencies
fftSig = fftSig(1:kNyq);
figure;
plot(posFreq,abs(fftSig));
xlabel('Frequency (Hz)');
ylabel('|FFT|');
title('Periodogram');

%Creating a Spectrogram

figure;
spectrogram(sigVec);
title('Spectrogram from function')

figure;
spectrogram(sigVec, 128,127,[],sampleFreq);
title('Defined Resolution Spectrogram')

winLen = 0.1;
ovrlp = 0.01;
winLenSampl = floor(winLen*sampleFreq);
ovrlpSampl = floor(ovrlp*sampleFreq);

[S,F,T]=spectrogram(sigVec, winLenSampl,ovrlpSampl,[],sampleFreq);
figure;
imagesc(T,F,abs(S));axis xy;
title('SFT Spectrogram')
xlabel('Time (sec)');
ylabel('Frequency (Hz)');