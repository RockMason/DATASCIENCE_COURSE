%% Minimize the fitness Function glrtqcsig4pso using PSO
clear; 
close all;
% Add paths to access required signal generator and PSO code(and its
% dependencies)
addpath SIGNALS\
addpath C:\Users\cicad\Documents\GitHub\SDMBIGDAT19\CODES
%Define Sampling Rate and Frequency
sampFreq = 1024;
nSamples = 2048;
dataLen = nSamples/sampFreq;
%Parameters of the signal
SNR = 100;
a1_0 = 10; 
a2_0 = 3;
a3_0 = 3;

kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);

noisePSD = @(f) (f>=50 & f<=100).*(f-50).*(100-f)/625 + 1;

psdPosFreq = noisePSD(posFreq);

%Colored Noise Realization
fltrOrder = 500;
outnoise = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],fltrOrder,sampFreq);

%Data Realization
dataX = 0:1/sampFreq:dataLen-1/sampFreq;
sigVec = qcsigfunc(dataX,SNR,[a1_0,a2_0,a3_0]);
[sigVec, ~] = normsig4psd(sigVec, sampFreq, psdPosFreq, 10);


dataY = sigVec+outnoise;

%Array  of values for a1

a1_min = 5;
a1_max = 15;

a2_min = 1;
a2_max = 5;
a3_min = 2;
a3_max = 10;

%Create Array A of values for a1, with max/min values a_max and a_min,
%with a given stepsize
delta_a1 = 0.1; %step size for A
A = a1_min:delta_a1:a1_max;


%Standardize coordinate values
X = zeros(length(A), 3);
X(:,1) = (A - a1_min) / (a1_max - a1_min);
X(:,2) = (a2_0 - a2_min) / (a2_max - a2_min);
X(:,3) = (a3_0 - a3_min) / (a3_max - a3_min);

%Create structure of data to feed into glrtqcsig4pso
params.dataY = dataY;
params.dataX = dataX;
params.dataXSq = dataX.^2;
params.dataXCb = dataX.^3;
params.psdPosFreq = psdPosFreq;
params.rmin = [a1_min, a2_min, a3_min];
params.rmax = [a1_max, a2_max, a3_max];
params.sampFreq = sampFreq;
params.snr = SNR;

[glrt,~] = glrtqcsig4pso(X,params);

% Plot fitness values against A
figure;
plot(A, glrt);
xlabel('a1');
ylabel('Fitness Value');
title('Fitness Values vs a1');
grid on;

% min
[minFitness, minIdx] = min(glrt);
hold on;
plot(A(minIdx), minFitness, 'ro', 'MarkerSize', 10);
text(A(minIdx), minFitness, sprintf('  Min at a1 ≈ %.2f', A(minIdx)), 'VerticalAlignment', 'bottom');

% Add a1 
line([a1_0, a1_0], ylim, 'Color', 'r', 'LineStyle', '--');
text(a1_0, max(ylim), sprintf('True a1 = %.2f', a1_0), 'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

legend('Fitness Values', 'Global Minimum', 'True a1');