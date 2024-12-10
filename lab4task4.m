% Clear workspace and close figures
clear; 
close all;
addpath ..\DATASCIENCE_COURSE\DETEST\
addpath ..\DATASCIENCE_COURSE\SIGNALS\
% Load signal parameters
a1 = 10; a2 = 3; a3 = 3;
signalParams = [a1, a2, a3];
sampFreq = 1024; % Sampling frequency in Hz

% Load the data realizations
data1 = load('DETEST/data1.txt');
data2 = load('DETEST/data2.txt');
data3 = load('DETEST/data3.txt');
    data1 = data1.';
    data2 = data2.';
    data3 = data3.';
dataRealizations = {data1, data2, data3};
nSamples = length(data1);
timeVec = (0:(nSamples-1))/sampFreq;
SNR = 10;
% Noise PSD function
noisePSD = @(f) (f >= 100 & f <= 300) .* (f - 100) .* (300 - f) / 10000 + 1;
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq); % Match size to DFT frequencies
disp(size(psdPosFreq)); % Debug: Check if size matches expectations
function glrt = glrtqcsig(dataVec, timeVec, sampFreq, psdvec, qcCoeff, A)
    % Generate the signal
    sigVec = qcsigfunc(timeVec, A, qcCoeff);

    % Normalize signal for PSD
    [templateVec, ~] = normsig4psd(sigVec, sampFreq, psdvec, 1);

    % Compute the log-likelihood ratio
    llr = innerprodpsd(dataVec, templateVec, sampFreq, psdvec);

    % Compute GLRT
    glrt = llr^2; % Ensure scalar output
end

% Generate GLRT values for the given data realizations
glrtValues = zeros(1, 3);
for i = 1:3
    glrtValues(i) = glrtqcsig(dataRealizations{i}, timeVec, sampFreq, psdPosFreq, signalParams, SNR);
    
end

% Initialize parameters for significance estimation
M = 1000; % Start with 1000 H0 realizations
maxIterations = 10; % Limit iterations to ensure runtime efficiency
tolerance = 1e-3; % Convergence tolerance for significance stabilization
previousSignificance = zeros(1, 3);

% Loop to calculate significance under H0
for iter = 1:maxIterations
    fprintf('Iteration %d: Generating %d H0 realizations\n', iter, M);
    h0GLRTValues = zeros(1, M);
    
    % Generate H0 realizations and calculate their GLRT values
        % Define psdVals as a 2-column matrix: first column is frequencies, second column is PSD values
    psdVals = [posFreq(:) psdPosFreq(:)];
    
    % Generate H0 realizations and calculate their GLRT values
    parfor j = 1:M % Use parallel computing for speed
        % Generate noise using statgaussnoisegen with the correct PSD values
        noise = statgaussnoisegen(nSamples, psdVals, 100, sampFreq);
        h0GLRTValues(j) = glrtqcsig(noise, timeVec, sampFreq, psdPosFreq, signalParams, SNR);
    end

    
    % Calculate significance for each data realization
    significance = zeros(1, 3);
    for i = 1:3
        significance(i) = mean(glrtValues(i) < h0GLRTValues); % p-value calculation
    end
    
    % Check for stabilization
    if max(abs(significance - previousSignificance)) < tolerance
        fprintf('Significance stabilized after %d iterations.\n', iter);
        break;
    end
    previousSignificance = significance;
    
    % Increase M for the next iteration
    M = M * 2; % Double the number of H0 realizations
end

% Display results
fprintf('GLRT values for data realizations: %s\n', mat2str(glrtValues));
fprintf('Significance levels: %s\n', mat2str(significance));

% Plot H0 GLRT histogram and given GLRT values
figure;
histogram(h0GLRTValues, 50, 'Normalization', 'pdf');
hold on;
xline(glrtValues, 'r--', 'Label', 'Data GLRT Values');
xlabel('GLRT Value');
ylabel('Probability Density');
title('GLRT Distribution under H_0');
legend('H_0 GLRT', 'Data GLRT');
grid on;