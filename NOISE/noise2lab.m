%%Noise Lab 2: Design Whitening Filter
clear
close all
format("short")
load("testData.txt") %load data

%Move data into vectors
timeVec = testData(:,1);
dataFrq = testData(:,2);
duration = timeVec(end);
nSamples = length(timeVec); %Number of samples in 5 secs
sampFrq = (nSamples-1)/duration; %Sampling Frequency for t<5sec
fprintf('The samping Frequency of the data is')
display(sampFrq, 'short')
%Initial Plots
figure
spectrogram(dataFrq)
title('Spectrogram of Data Before Whitening')
figure
plot(timeVec,dataFrq)
title('Data Series Before whitening')
ylabel('Power')
xlabel('Time Series')


%Estimate the PSD for the data

noisevec = dataFrq(1:5121);
[psdEst,f] = pwelch(noisevec);
figure
plot(f,psdEst)
title('Welch Power Spectral Density Estimate')


%Filter design
fltordr = 500;
psdvec = psdEst;

f = f/pi;
wfilter = fir2(fltordr,f,sqrt(psdvec));

outnoise = sqrt(sampFrq)*fftfilt(wfilter,dataFrq);

[paff,faff] = pwelch(outnoise);

figure
plot(timeVec,outnoise)
title('Data Series after Whitening')
figure
spectrogram(outnoise)
title('Spectrogram After Whitening')


