%{
        A demo for regression using RVM with hybrid_kernel
%}

clc
clear all
close all
addpath(genpath(pwd))

% sinc funciton
fun = @(x) sin(abs(x))/abs(x);
x = linspace(-10,10, 100);
y = arrayfun(fun, x);
trainData = x';
trainLabel = y';
xt = linspace(-10, 10, 20);
yt = arrayfun(fun, xt);
testData = xt';
testLabel = yt';

% kernel function
kernel_1 = Kernel('type', 'gaussian', 'gamma', 0.3);
kernel_2 = Kernel('type', 'polynomial', 'degree', 2);
kernelWeight = [0.5, 0.5];
% parameter
parameter = struct( 'display', 'on',...
                    'type', 'RVR',...
                    'kernelFunc', [kernel_1, kernel_2],...
                    'kernelWeight', kernelWeight);
rvm = BaseRVM(parameter);

% RVM model training, testing, and visualization
rvm.train(trainData, trainLabel);
results = rvm.test(trainData, trainLabel);
rvm.draw(results)

