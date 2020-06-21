% @brief exgauss_rnd generates a matrix of random numbers from the 
% exponentially modified Gaussian (exGaussian) distribution; 
%
% INPUT
%   - mu - mean of Gaussian component (scalar); 
%   - sigma - standard deviation of Gaussian (scalar); 
%   - tau - mean of exponential component (scalar); 
%   - m - requested number of rows for the generated matrix (default 1);
%   - n - requested columns of rows for the generated matrix (default 1).
%     If m and n are not provided, single random number is generated.
%
% OUTPUT:
%   - r - m-by-n array containing exGaussian random numbers
%
% @author Anton Unakafov
% @date 16.03.2018
% @email antonunakafov(at)hotmail.com

function r = exgauss_rnd(mu, sigma, tau, m, n)
  if (~exist('m', 'var'))
    m = 1;
  end
  if (~exist('n', 'var'))
    n = 1;
  end
  r = normrnd(mu, sigma, m, n) + exprnd(tau, m, n);
end