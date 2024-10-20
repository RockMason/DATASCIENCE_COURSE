%% Filtering of sum of 3 Sinusoids

%Parameters
A1 = 10;
A2 = 5;
A3 = 2.5;
f01 = 100;
f02 = 200;
f03 = 300;
phi01 = 0;
phi02 = pi/6;
phi03 = pi/4;

%Define Signal duration and sampling rate
sampFreq = 1024;
nSamples = 2048;

timeVec = (0:(nSamples-1))/sampFreq;

sigLen = (nSamples-1)/sampFreq;


%%Create 3 sinusoidal signals and find their corrisponding maximum
%%frequencies

%For all signals, x(t)= Asin(2pi*f0*t+phi0)
%phase: phi(t) = 2pi*f0*t+phi0
% Instantaneous frequency:  1/(2*pi)*d(phi(t))/dt (normalized over 2*pi)

%Signal 1
sigVec1 = sinsigfunc(timeVec,A1,f01,phi01);
maxFreq1 = 100 ;
%Signal 2
sigVec2 = sinsigfunc(timeVec,A2,f02,phi02);
maxFreq2 = 200 ;
%Signal 3
sigVec3 = sinsigfunc(timeVec,A3,f03,phi03);
maxFreq3 = 300 ;
%Add signals
sumVec = sigVec1+sigVec2+sigVec3; 



%%Creating Filters (Returns Signal 1)
filtOrder = 40; %Filter Order
%Filter 1

w1 = (maxFreq1/2)/(sampFreq/2);
B1 = fir1(filtOrder,w1,"low") ;
filtSig1 = fftfilt(B1,sumVec); 

%Filter 2 (Returns Signal 3
w2 =  (maxFreq2/2)/(sampFreq/2);
B2 = fir1(filtOrder,w2 , "high") ;
filtSig3 = fftfilt(B2,sigVec);

%Filter 3 (Returns signal 2)
window = [w1,w2];
B3 = fir1(filtOrder,window , "bandpass") ;
filtSig2 = fftfilt(b,sigVec);
    
%%Plots

%Unfiltered Signal
figure
plot(timeVec,sumVec,'-');

%Plot for filter 1 
figure;
hold on;
plot(timeVec,sumVec,'-')
plot(timeVec,filtSig1)



%Plot for Filter 2
figure;
hold on;
plot(timeVec,sumVec,'-')
plot(timeVec,filtSig3)



%Plot for Filter 3
figure;
hold on;
plot(timeVec,sumVec,'-')
plot(timeVec,filtSig2)


