%%Compute GLRT for a Quadratic Chirp

function glrt = glrtqcsig(dataVec, timeVec, sampFreq, psdvec, qcCoeff, A)
addpath SIGNALS\
sigVec = qcsigfunc(timeVec, A, qcCoeff);

[templateVec,~] = normsig4psd(sigVec,sampFreq,psdvec,1);

llr = innerprodpsd(dataVec,templateVec,sampFreq,psdvec);

glrt = llr^2;