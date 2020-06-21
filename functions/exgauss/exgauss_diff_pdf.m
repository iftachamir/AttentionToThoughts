% @brief exgauss_diff_pdf returns the probability density function (pdf) 
% of the difference of two random variables from the exponentially modified 
% Gaussian (exGaussian) distribution
%
% INPUT
%   - t - values at which to evaluate the pdf, specified as a scalar value 
%         or an array of scalar values;
%   - mu1 - mean of Gaussian component for the first random variable (scalar); 
%   - sigma1 - standard deviation of Gaussian for the first random variable (scalar); 
%   - tau1 - mean of exponential component for the first random variable (scalar); 
%   - mu2 - mean of Gaussian component for the second random variable (scalar); 
%   - sigma2 - standard deviation of Gaussian for the second random variable (scalar); 
%   - tau2 - mean of exponential component for the second random variable (scalar); 
%
% OUTPUT:
%   - pdf - pdf values, evaluated at the values in t, returned as a scalar 
%           value or an array of scalar values. pdf is the same size as t
%
% EXAMPLE of use 
%{
x = 0:0.001:9;
dltX = -7:0.001:6;
m1 = 3; std1 = 1.0; tau1 = 1;
m2 = 2; std2 = 0.5; tau2 = 2;
rt1 = exgauss_pdf(x, m1, std1, tau1);
rt2 = exgauss_pdf(x, m2, std2, tau2);

dRT = exgauss_diff_pdf(dltX, m1,std1,tau1,m2,std2,tau2);

figure
LineWidth = 2;
subplot(2,1,1)
hold on
plot (x, rt1, 'b-', 'linewidth', LineWidth);
plot (x, rt2, 'r-', 'linewidth', LineWidth);
hold off;
axis( [0.4, max(x), 0, 1.05*max(rt1)] );

subplot(2,1,2)
plot (dltX, dRT, 'm-', 'linewidth', LineWidth);
axis( [min(dltX), max(dltX), 0, 1.05*max(dRT)] );


%}
% @author Anton Unakafov
% @date 16.03.2018
% @email antonunakafov(at)hotmail.com

function pdf = exgauss_diff_pdf(t, mu1, sigma1, tau1, mu2, sigma2, tau2)
  nPoint = length(t);
  
  %generate sufficient number of samples from both distributions 
  N = 200*nPoint; % emprically chosen number of samples
  X = exgauss_rnd(mu1, sigma1, tau1, 1, N); % samples from the first distribution
  Y = exgauss_rnd(mu2, sigma2, tau2, 1, N); % samples from the second distribution
  
  % estimate pdf from the differences of generated samples
  epsilon = 0.0001; %a very small number to cover all t values
  edges = ([t(1) - epsilon, t] + [t, t(end) + epsilon])/2;
  integrStep = edges(2:end) - edges(1:end-1); 
  pdf = (histcounts(X - Y, edges)./N)./integrStep;
  
  % smooth the estimated pdf
  pdf = movmean(pdf, round(nPoint/20)); 
end