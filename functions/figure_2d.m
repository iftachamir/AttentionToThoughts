function fig = figure_2d(vf)

set( gca, 'FontName', 'Times New Roman' );

fig = figure("Visible",false);
left_color = [0 0 0];
right_color = [1 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);


x = 1:vf.numOfIterations;
% smoothEmotion = smooth(Emotion,30);
% smoothAttention = smooth(InternalAttention,30);
smoothEmotion = smoothdata(vf.Emotion, 'gaussian', 10);
smoothAttention = smoothdata(vf.InternalAttention.valence, 'gaussian', 10);
yyaxis left
hold on
% p1 = plot(x, InternalAttention, '--b', ...
%     x, Emotion, '--r');
p2 = plot(x, smoothAttention, '-k', 'LineWidth', 1);

ylim([-.1 1.1])
ylabel('Selection bias')

yyaxis right
p2 = plot(x, smoothEmotion, '-r', 'LineWidth', 1);
ylim([-.5 5.5])

% Add dots reflecting thought type
a = max([(smoothAttention.*5), smoothEmotion]) + .3;
b = a + .4;
r = (b-a).*rand(vf.numOfIterations,1) + a;
s = gscatter(x, r, vf.selectedThought.valence, ...
    'br','.',9);

title(vf.title, 'HorizontalAlignment', 'right')
xlabel('Time (secs)')
ylabel('Negative affect')
legend(["Attention"; ...
    "Affect"; ...
    "Neutral Thought"; ...
    "Negative Thought"])
hold off

fig.Units = 'centimeters';
x0=10;
y0=10;
width=16.5;
height=6;
fig.Position = [x0,y0,width,height];
%set(gcf,'position',[x0,y0,width,height])

