%%  Mock Data Challenge
clear
close all
%Add paths to dependencies
addpath 'C:\Users\cicad\Documents\GitHub\SDMBIGDAT19\CODES'
addpath 'C:\Users\cicad\Documents\GitHub\DATASCIENCE_COURSE\DETEST'

%Load Data
load analysisData.mat
load TrainingData.mat

Fs = sampFreq;

%Estimate PSD for Noise using Welch's Method
window = 256;
noverlap = window / 2; % 50% overlap
nfft = 2*sampFreq; % Number of FFT points
[psd, f] = pwelch(trainData,window,noverlap,nfft);

% Plot the PSD
figure;
plot(f, 10*log10(psd));
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
title('Power Spectral Density Estimate of the Noise');
grid on;


psdPosFreq = psd';


nSamples = length(dataVec);

dataLen = nSamples/Fs;
timeVec = (0: (nSamples-1)) / sampFreq;

%Visualize Signal
figure
plot(timeVec, dataVec)
title('Plot of the Signal')
xlabel('Time Series')
ylabel('Signal')

dataX = timeVec;
dataY = dataVec;

SNR = 10; %desired SNR for signal

%Search Parameters for PSO
rmin = [40, 1, 1];
rmax = [100 , 50, 15];
% Number of independent PSO runs
nRuns = 8;


rng('default');
% Input parameters for CRCBQCHRPPSO
inParams = struct('dataX', dataX,...
                  'dataY', dataY,...
                  'dataXSq',dataX.^2,...
                  'dataXCb',dataX.^3,...
                  'snr',SNR, ...
                  'sampFreq',Fs, ...
                  'psdPosFreq',psdPosFreq,...
                  'rmin',rmin,...
                  'rmax',rmax);
%Run PSO
outStruct = pso4glrt(inParams,struct('maxSteps',1000),nRuns);
%%
% Plots
figure;
hold on;
plot(dataX,dataY,'.');
% plot(dataX,sigVec);
for lpruns = 1:nRuns
    plot(dataX,outStruct.allRunsOutput(lpruns).estSig,'Color',[51,255,153]/255,'LineWidth',4.0);
end
plot(dataX,outStruct.bestSig,'Color',[76,153,0]/255,'LineWidth',2.0);
legend('Data','Signal',...
       ['Estimated signal: ',num2str(nRuns),' runs'],...
       'Estimated signal: Best run');
disp(['Estimated parameters: a1=',num2str(outStruct.bestQcCoefs(1)),...
                             '; a2=',num2str(outStruct.bestQcCoefs(2)),...
                             '; a3=',num2str(outStruct.bestQcCoefs(3))]);