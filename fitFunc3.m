function [fitVal,varargout] = fitFunc3(xVec, params)
%Benchmark Fitness Function for Generalized Rosenbrock
% Rock Mason 2024
%rows: points
%columns: coordinates of a point
[nrows,~]=size(xVec);

%storage for fitness values
fitVal = zeros(nrows,1);
validPts = ones(nrows,1);

%Check for out of bound coordinates and flag them
validPts = crcbchkstdsrchrng(xVec);
%Set fitness for invalid points to infty
fitVal(~validPts)=inf;
%Convert valid points to actual locations
xVec(validPts,:) = s2rv(xVec(validPts,:),params);

for lpc = 1:nrows
    if validPts(lpc)
        x = xVec(lpc,:);
        
        fitVal(lpc) = sum(100*(x(2:end)-x(1:end-1).^2).^2+(x(1:end-1)-1).^2);
    end
end

%Return real coordinates if requested
if nargout > 1
    varargout{1}=xVec;
    if nargout > 2
        varargout{2} = r2sv(xVec,params);
    end
end
