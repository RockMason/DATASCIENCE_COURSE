%%LIGO Noise Simulation
clear
close all
load \Users\cicad\Documents\GitHub\DATASCIENCE_COURSE\NOISE\iLIGOSensitivity.txt
gwdata = iLIGOSensitivity;
gwdata = [0, 0 ; gwdata]; %PDF of Signal 
%Normalize the Frequencies
freqVec = gwdata(:,1);
sqrtPSD = gwdata(:,2);
psdVec = sqrtPSD.^2;
figure
loglog(freqVec,psdVec);
xlabel('Frequency (Hz)')
ylabel('PSD')

%Set Signal Duration and Sampling Rate
nSamples = 1000;
sampFreq = 2048;
timeVec = (0: (nSamples-1)/sampFreq);
nyqFreq = sampFreq/2;

%Generate White Noise Gaussian

inNoise = randn(1,nSamples); 
%Filter Out 
cutLow = 50;
cutHigh = 700;
normLow = cutLow/(sampFreq/2);
normHigh = cutHigh/(sampFreq/2);
fltrOrdr = 500;
%Filter out S_n(50)<S_n and S_n<S_n(700)

bandFilt = fir1(fltrOrdr,[normLow, normHigh], "bandpass");
filtFreq = fftfilt(bandFilt,freqVec);
figure
loglog(filtFreq,psdVec)
BWGN = fir2(fltrOrdr,filtFreq/(sampFreq/2),sqrtPSD); 

outNoise = sqrt(sampFreq)*fftfilt(BWGN,inNoise); %Apply Transfer Function
[pxx, f] = pwelch(outNoise); %Estimate PDF of GW noise

figure
plot(f,pxx)
xlabel('Frequency (Hz)');
ylabel('PSD');
figure
plot(timeVec,outNoise);


