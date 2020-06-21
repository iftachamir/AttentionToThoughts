
%% Exgauss

% Figure A
mu = .25;
sig = .1;
tau = [0.1, .25, .75, 1.5];
n_plots = length(mu) * length(tau);
x = 0:0.01:3;

%%% 1
resp = exgauss_pdf(x, mu, sig, tau(1));
resp(resp<0) = 0;
plot(x, resp, 'k-', 'linewidth', 2);
hold on

%%% 2
resp = exgauss_pdf(x, mu, sig, tau(2));
resp(resp<0) = 0;
plot(x, resp, 'b-', 'linewidth', 2);

%%% 3
resp = exgauss_pdf(x, mu, sig, tau(3));
resp(resp<0) = 0;
plot(x, resp, 'g-', 'linewidth', 2);

%%% 4
resp = exgauss_pdf(x, mu, sig, tau(4));
resp(resp<0) = 0;
plot(x, resp, 'r-', 'linewidth', 2);

legend(["Mu = .25   Sigma = .1   Tau = 0.10"; ...
    "Mu = .25   Sigma = .1   Tau = 0.25"; ...
    "Mu = .25   Sigma = .1   Tau = 0.75"; ...
    "Mu = .25   Sigma = .1   Tau = 1.50"], ...
    'Box', 'off')
title('Probability density functions for varying Tau values')
ylabel('Density')
xlabel('Likelihood of selective attention to negative representations', ...
    'HorizontalAlignment', 'center')
axis tight
%annotation('textarrow',[.77 .9],[.07 .07])
hold off

f = gcf;
a = f.CurrentAxes;
a.Box = 'off';
a.FontName = 'Times new roman';
a.FontSize = 12;
a.XTick = [0.1, 2.9];
a.XTickLabel = {'Low', 'High'};
a.YTick = ylim;
a.YTickLabel = {'0', '1'};
%%%%%%%%%

% Figure B
mu = .25;
sig = .1;
tau = .75;
n_plots = length(mu) * length(tau);
x = 0:0.01:3;

resp = exgauss_pdf(x, mu, sig, tau(1));
resp(resp<0) = 0;
plot(x, resp, 'k-', 'linewidth', 2);

f = gcf;
a = f.CurrentAxes;
a.Box = 'off';
a.FontName = 'Times new roman';
a.FontSize = 12;
a.XTick = [0.1, 2.9];
a.XTickLabel = {'Low', 'High'};
%a.YTick = ylim;
a.YTickLabel = [];
%%%%%%%%%%




%% Nakagami
figure;
mu = 2;
sigma = [0.1, .25, .75, 1.5];
c = {'k', 'b', 'g', 'r'};
x = 0:.01:3;

for i = 1:length(sigma)
    dist = makedist(...
        'Nakagami','mu',mu, ...
        'omega',sigma(i));
    
    pdf_x = pdf(dist, x);
    
    hold on
    plot(x,pdf_x,'LineWidth',2,'LineStyle','-','Color',c{i})
end
hold off

legend(["Mu = .25   Sigma = 0.10"; ...
    "Mu = .25   Sigma = 0.25"; ...
    "Mu = .25   Sigma = 0.75"; ...
    "Mu = .25   Sigma = 1.50"], ...
    'Box', 'off')
title('Probability density functions for varying Tau values')
ylabel('Density')
xlabel('Likelihood of selective attention to negative representations', ...
    'HorizontalAlignment', 'center')
axis tight




%%

m1 = .1; std1 = 1.0; tau1 = 1; %parameters of reaction time for Participant 1
% generate distributions of reaction times (rt)
mu = [0.01 .5];
sig = .1;
tau = 0.1:.33:2;
n_plots = length(mu) * length(tau);
x = 0:0.01:3;

i = 0;
for imu = 1:length(mu)
    for itau = 1:length(tau)
        resp = tanh(exgauss_rnd(mu(imu), sig, tau(itau),1000,1));
        resp(resp<0) = 0;
        i = i + 1;
        subplot(length(mu), length(tau), i)
        histogram(resp, 10)
        title("Mu=" + num2str(mu(imu)) + "; Tau=" + num2str(tau(itau)))
    end
end





rt1 = exgauss_pdf(x, m1, std1, tau1);
rt2 = exgauss_pdf(x, m2, std2, tau2);

LineWidth = 2;
plot(x, rt1, 'b-', 'linewidth', LineWidth);