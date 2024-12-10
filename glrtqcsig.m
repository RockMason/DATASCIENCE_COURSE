function glrt = glrtqcsig(dataVec, timeVec, sampFreq, psdvec, qcCoeff, A)
    % Generate the signal
    sigVec = qcsigfunc(timeVec, A, qcCoeff);
    disp('Signal size:');
    disp(size(sigVec)); % Check signal size

    % Normalize signal for PSD
    [templateVec, ~] = normsig4psd(sigVec, sampFreq, psdvec, 1);
    disp('Template size:');
    disp(size(templateVec)); % Check template size

    % Compute the log-likelihood ratio
    llr = innerprodpsd(dataVec, templateVec, sampFreq, psdvec);
    disp('LLR size:');
    disp(size(llr)); % Check LLR size

    % Ensure scalar GLRT
    glrt = llr^2; 
    disp('GLRT value:');
    disp(glrt); % Check GLRT value

    % Ensure the output is a scalar
    if numel(glrt) > 1
        error('GLRT is not scalar! Check input and output dimensions.');
    end
end
