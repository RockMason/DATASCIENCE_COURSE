%%RNG Lab
close all;
clear;


n = 10000; %Number of Trials
%Using 'rand'generates uniformly distributed values
r1 = rand(n,1);
figure
histogram(r1)


%using 'randn'generates a normal distribution
r2 = randn(n);
figure
histogram(r2)


%using rng
rng("default")
n2 = 5000;
A = randn(n2);
s = rng;
A = randn(n2); 
rng(s)
a = randn(n2);
figure
histogram(a)
b = randn(n2);
figure
histogram(b)

%%WGN 

wgnSamp = 10000;

%mu=0, sigma =1
mu1 = 0;
sigma1 = 1;
wgn1 = sigma1.*randn(wgnSamp,1)+mu1;
figure
histogram(wgn1)
stats1 = [mean(wgn1),std(wgn1)];
%mu=0, sigma =2
mu2 = 2;
sigma2 = 2;
wgn2 = sigma1.*randn(wgnSamp,1)+mu1;
figure
histogram(wgn2)
stats2 = [mean(wgn2),std(wgn2)];
%mu=0, sigma^2 =2 (variance)
mu3 = 0;
v1 = 2;
sigma3 = sqrt(v1);
wgn3 = sigma3.*randn(wgnSamp,1)+mu3;
figure
histogram(wgn3)
stats3 = [mean(wgn3),std(wgn3)];
%mu=2, simga^2 =2(variance)
mu4 = 2;
v2 = 2;
sigma4 = sqrt(v2);
wgn4 = sigma4.*randn(wgnSamp,1)+mu4;
figure
histogram(wgn4)
stats4 = [mean(wgn4),std(wgn4)];

%%Trivariate Normal Distribution
%Linear combination of 3 uncorrelated Normal random variables

%Number of Trials
ntrials = 10000;
%Trial values of 3 uncorrelated Normal random variables
X = randn(1,ntrials);
Y = randn(1,ntrials);
Z = randn(1,ntrials);

stdevX = std(X);
stdevY = std(Y);
stdevZ = std(Z);






%Scatterplot of Trials
plot3(,,'.');
axis tight;
axis equal;
xlabel('Trial values of I');
ylabel('Trial Values of J');
zlabel('Trial values of K');
