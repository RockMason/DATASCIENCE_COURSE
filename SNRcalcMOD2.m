%% How to normalize a signal for a given SNR
% We will normalize a signal such that the Likelihood ratio (LR) test for it has
% a given signal-to-noise ratio (SNR) in noise with a given Power Spectral 
% Density (PSD). [We often shorten this statement to say: "Normalize the
% signal to have a given SNR." ]
clear
close all
%%
% Path to folder containing signal and noise generation codes
addpath SIGNALS\
addpath NOISE\
addpath DETEST\

%%
% This is the target SNR for the LR
snr = 1;

%%
% Data generation parameters
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;


%%
% Generate the signal that is to be normalized
a1=10;
a2=3;
a3=3;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; 
sigVec = qcsigfunc(timeVec,A,[a1,a2,a3]);

%%
% Noise PSD provided by iLIGOSensitivity.txt
data = load('iLIGOSensitivity.txt');
LIGOfreq = data(:,1);
LIGOPSDval = data(:,2);


%%
% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
% Achiveed Via Interpolation of LIGO sensitivity values over the DFT values
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = interp1(LIGOfreq, LIGOPSDval, posFreq, 'linear', 'extrap');
figure;
% Plot results
figure;
loglog(LIGOfreq, LIGOPSDval, 'o', 'DisplayName', 'Original PSD');
xlabel('Frequency (Hz)');
ylabel('PSD');
title('Original PSD');
grid on;
figure
loglog(posFreq, psdPosFreq, '-', 'DisplayName', 'Interpolated PSD');
xlabel('Frequency (Hz)');
ylabel('PSD');
title('Interpolation of PSD to DFT Frequencies');
grid on;

%% Calculation of the norm
% Norm of signal squared is inner product of signal with itself
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
% Normalize signal to specified SNR
sigVec = snr*sigVec/sqrt(normSigSqrd);

%% Test
%Obtain LLR values for multiple noise realizations
nH0Data = 1000;
llrH0 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    llrH0(lp) = innerprodpsd(noiseVec,sigVec,sampFreq,psdPosFreq);
end
%Obtain LLR for multiple data (=signal+noise) realizations
nH1Data = 1000;
llrH1 = zeros(1,nH1Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    % Add normalized signal
    dataVec = noiseVec + sigVec;
    llrH1(lp) = innerprodpsd(dataVec,sigVec,sampFreq,psdPosFreq);
end
%%
% Signal to noise ratio estimate
estSNR = (mean(llrH1)-mean(llrH0))/std(llrH0);

figure;
histogram(llrH0);
hold on;
histogram(llrH1);
xlabel('LLR');
ylabel('Counts');
legend('H_0','H_1');
title(['Estimated SNR = ',num2str(estSNR)]);

%%
% A noise realization
figure;
loglog(timeVec,noiseVec);
title('Noise Realization')
xlabel('Time (sec)');
ylabel('Noise');
%%
% A data realization
figure;
loglog(timeVec,dataVec);
hold on;
loglog(timeVec,sigVec);
xlabel('Time (sec)');
ylabel('Data');
%Periodogram
figure
periodogram(psdPosFreq, [], [], sampFreq);
%Spectrogram
figure
spectrogram(psdPosFreq, 256, 250, 256, sampFreq, 'yaxis');