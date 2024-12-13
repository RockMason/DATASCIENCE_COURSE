function glrt = glrtqcsig(dataVec, timeVec, sampFreq, psdvec, qcCoeff, A)
    % Generate the signal
    sigVec = qcsigfunc(timeVec, A, qcCoeff);


    % Normalize signal for PSD
    [templateVec, ~] = normsig4psd(sigVec, sampFreq, psdvec, 1);


    % Compute the log-likelihood ratio
    llr = innerprodpsd(dataVec, templateVec, sampFreq, psdvec);


    % Ensure scalar GLRT
    glrt = llr^2; 


    % Ensure the output is a scalar
    if numel(glrt) > 1
        error('GLRT is not scalar! Check input and output dimensions.');
    end
end
