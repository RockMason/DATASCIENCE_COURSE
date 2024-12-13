%% Script OT test GLRT of a Quadratic Chirp Signal in colored noise using PSO
addpath DETEST/
addpath DSP/
addpath GWDATA/
addpath MDC/
addpath NOISE/
addpath SIGNALS/
addpath ..\SDMBIGDAT19\CODES\
clear
close all
% Data length
nSamples = 512;
% Sampling frequency
Fs = 512;
% Signal to noise ratio of the true signal
SNR = 10;
% Phase coefficients parameters of the true signal
a1 = 10;
a2 = 3;
a3 = 3;

% Search range of phase coefficients
rmin = [1, 1, 1];
rmax = [180, 10, 10];
dataX = (0:(nSamples-1))/Fs;

%Generate Data Realization
dataLen = nSamples/Fs;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);

noisePSD = @(f) (f>=50 & f<=100).*(f-50).*(100-f)/625 + 1;

psdPosFreq = noisePSD(posFreq);

%Colored Noise Realization
fltrOrder = 500;
outnoise = statgaussnoisegen(nSamples*4,[posFreq(:),psdPosFreq(:)],fltrOrder,Fs);
%SDM:
%Filter order is very high and startup transient needs to be removed. So,
%generate a long duration noise realization and drop the first fltrOrder
%samples.
outnoise = outnoise(fltrOrder:(fltrOrder+nSamples-1));

sigVec = qcsigfunc(dataX,SNR,[a1,a2,a3]);
[sigVec, ~] = normsig4psd(sigVec, Fs, psdPosFreq, 10);


dataY = sigVec+outnoise;
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
plot(dataX,sigVec);
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


