%% Filtering of sum of 3 Sinusoids

%Parameters
A1 = 10;
A2 = 5;
A3 = 2.5;
f01 = 100;
f02 = 200;
f03 = 300;
phi01 = 0;
phi02 = pi/6;
phi03 = pi/4;

%Define Signal duration and sampling rate
sampFreq = 1024;
nSamples = 2048;

timeVec = (0:(nSamples-1))/sampFreq;

sigLen = (nSamples-1)/sampFreq;


%%Create 3 sinusoidal signals and find their corrisponding maximum
%%frequencies


%Signal 1
sigVec1 = sinsigfunc(timeVec,A1,f01,phi01);

%Signal 2
sigVec2 = sinsigfunc(timeVec,A2,f02,phi02);

%Signal 3
sigVec3 = sinsigfunc(timeVec,A3,f03,phi03);

%Add signals
sumVec = sigVec1+sigVec2+sigVec3; 

maxFreq = instfreq(sumVec, sampFreq);
maxFreq = maxFreq(1);

%Unfiltered Signal
    figure
plot(timeVec,sumVec);


%%%Creating Filters (Returns Signal 1)
filtOrder = 40; %Filter Order
dataLen = timeVec(end)-timeVec(1);
%dft sample
kNyq=floor(nSamples/2)+1;
%Identify positive frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);

%%Filter 1

w1 = (2*maxFreq)/(sampFreq);
B1 = fir1(filtOrder,w1,"low") ;
filtSig1 = fftfilt(B1,sumVec); 
%Plot of Filter1
fftSig1 = fft(filtSig1);
%Discarding Negative Frequencies
fftSig1 = fftSig1(1:kNyq);
figure;
plot(posFreq,abs(fftSig1));
xlabel('Frequency (Hz)');
ylabel('|FFT|');
title('Periodogram of Signal 1');

%%Filter 2 (Returns Signal 3)
w2 =  (4*maxFreq)/(sampFreq);
B2 = fir1(filtOrder,w2 , "high") ;
filtSig3 = fftfilt(B2,sumVec);
%Plot for Filter 2
fftSig3 = fft(filtSig3);
%Discarding Negative Frequencies
fftSig3 = fftSig3(1:kNyq);
figure;
plot(posFreq,abs(fftSig3));
xlabel('Frequency (Hz)');
ylabel('|FFT|');
title('Periodogram of Signal 3');


%%Filter 3 (Returns signal 2)
wn = [w1,w2];
B3 = fir1(filtOrder,wn , "bandpass") ;
filtSig2 = fftfilt(B3,sumVec);
%Plot for Filter 3
fftSig2 = fft(filtSig2);
%Discarding Negative Frequencies
fftSig2 = fftSig2(1:kNyq);
figure;
plot(posFreq,abs(fftSig2));
xlabel('Frequency (Hz)');
ylabel('|FFT|');
title('Periodogram of Signal 2');

