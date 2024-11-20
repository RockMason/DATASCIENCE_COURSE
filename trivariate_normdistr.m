%%Noise Lab 1 Trivariate Normal Distribution
clear;
close all;
n = 1000;
mu = zeros(3,1); %zero mean    
X1 = randn(1,n);
X2 = randn(1,n);
X3 = randn(1,n);
X = [X1;X2;X3];
A = randn(3,3);
Y = A*X;
figure
plot3(X1,X2,X3,'.')
figure
plot3(Y(1,:),Y(2,:),Y(3,:),'.')

% fprintf('Covariance Matrix')
% display(A)
% B = corrcoef(A);
% fprintf('Correlation Coefficients')
% display(B)
% 
% Z = sqrtm(A).*X; 
% display(Z)
% plot3(Z(1),Z(2),Z(3));