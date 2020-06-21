% @brief exgauss_pdf returns the probability density function (pdf) of the 
% exponentially modified Gaussian (exGaussian) distribution; 
%
% INPUT
%   - x - values at which to evaluate the pdf, specified as a scalar value 
%         or an array of scalar values;
%   - mu - mean of Gaussian component (scalar); 
%   - sigma - standard deviation of Gaussian (scalar); 
%   - tau - mean of exponential component (scalar); 
%
% OUTPUT:
%   - pdf - pdf values, evaluated at the values in x, returned as a scalar 
%           value or an array of scalar values. pdf is the same size as x
%
% @author Anton Unakafov
% @date 21.02.2019
% @email antonunakafov(at)hotmail.com

function pdf = exgauss_pdf(x, mu, sigma, tau)
  if license('test', 'Symbolic_Toolbox')
      useVPA = 1; % compute with additional precision
  else
      useVPA = 0;
  end    
  if (tau > 0 && sigma > 0) %check for correctness
      % preliminary computations
      if useVPA
        sigmaPerTau = vpa(sigma./tau);         
      else  
        sigmaPerTau = sigma./tau;  
      end  
      muMinusX = mu - x;
      normalPart = 1 - normcdf(muMinusX./sigma + sigmaPerTau);
      expPart = muMinusX./tau + (sigmaPerTau.^2)./2;
      if (useVPA)
          pdf = double((1/tau).*normalPart.*exp(expPart));
      else
          if (expPart > 25)
              warning('The combination of the input values may result in numerical instability. Please change your units to make (mu-x)/tau < 25 and sigma/tau < 5. Then please re-run the script')
          end  
          pdf = (1/tau).*normalPart.*exp(expPart);
      end
  else
      pdf = zeros(length(x), 1);
  end
  pdf(pdf==Inf) = 0;
end