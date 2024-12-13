function [glrt,varargout] = glrtqcsig4pso(X,params)
%Fitness function for quadratic chirp regression
%F = CRCBQCFITFUNC(X,P)
%Compute the fitness function ( log-likelihood ratio for colored noise
%maximized over the aplitude parameter) for data containing the
%quadratic chirp signal. X.  The fitness values are returned in F. X is
%standardized, that is 0<=X(i,j)<=1. The fields P.rmin and P.rmax  are used
%to convert X(i,j) internally before computing the fitness:
%X(:,j) -> X(:,j)*(rmax(j)-rmin(j))+rmin(j). 
%The fields P.dataY and P.dataX are used to transport the data and its
%time stamps. The fields P.dataXSq and P.dataXCb contain the timestamps
%squared and cubed respectively. The fields P.PSD contains the PSD values
%for positive DFT fre 

%==========================================================================
%rows: points
%columns: coordinates of a point
[nVecs,~]=size(X);

%storage for fitness values
glrt = zeros(nVecs,1);

%Check for out of bound coordinates and flag them
validPts = crcbchkstdsrchrng(X);
%Set fitness for invalid points to infty
glrt(~validPts)=inf;
X(validPts,:) = s2rv(X(validPts,:),params);

for lpc = 1:nVecs
    if validPts(lpc)
    % Only the body of this block should be replaced for different fitness
    % functions
        x = X(lpc,:).*(params.rmax - params.rmin) + params.rmin;

        % Generate the signal
       phaseVec = x(1)*params.dataX + x(2)*params.dataX.^2 + x(3)*params.dataX.^3;
        sigVec = sin(2*pi*phaseVec);
        sigVec = params.snr*sigVec/norm(sigVec);
        % Normalize signal for PSD
        [templateVec, ~] = normsig4psd(sigVec, params.sampFreq, params.psdPosFreq, 1);
    
    
        % Compute the log-likelihood ratio
        llr = innerprodpsd(params.dataY, templateVec, params.sampFreq, params.psdPosFreq);

        glrt(lpc) = llr^2;
    end
end

%Return real coordinates if requested
if nargout > 1
    varargout{1}=X;
end


