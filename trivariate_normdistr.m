%%Noise Lab 1 Trivariate Normal Distribution
clear;
close all;
n = 10000;
mu = zeros(3,1); %zero mean    
X1 = randn(n,1);
X2 = randn(n,1);
X3 = randn(n,1);
X = [X1 X2 X3];
A = cov(X);
fprintf('Covariance Matrix')
display(A)
B = corrcoef(A);
fprintf('Correlation Coefficients')
display(B)

Z = sqrtm(A).*X; 
display(Z)
plot3(Z(1),Z(2),Z(3));