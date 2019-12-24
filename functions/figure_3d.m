function fig = figure_3d(vf)

%set( gca, 'FontName', 'Times New Roman' );

fig = figure("Visible",true);
x = 1:vf.numOfIterations;

smoothEmotion = smoothdata(vf.Emotion, 'gaussian', 10);
smoothAttention_valence = ...
    smoothdata(vf.InternalAttention.valence, 'gaussian', 10);
smoothAttention_irrelevance = ...
    smoothdata(vf.InternalAttention.irrelevance, 'gaussian', 10);

hold on
p1 = plot(x, smoothAttention_valence, '-k', ...
    x, smoothEmotion, '-r', ...
    x, smoothAttention_irrelevance, '-g', ...
    'LineWidth', 1);

% Add dots reflecting thought type
a = max([smoothAttention_valence, smoothEmotion]) + .05;
b = a + .05;
r = (b-a).*rand(vf.numOfIterations,1) + a;
s = gscatter(x, r, vf.selectedThought.valence, ...
    'br','.',7);
hold off

legend(["Attention"; "Emotion"; "TaskIrrelevance"; "Neutral Thought"; "Negative Thought"])
ylim([-.1 1.1])
title(vf.title)
xlabel('Time (secs)')
ylabel('Selection bias')

fig.Units = 'centimeters';
x0=10;
y0=10;
width=16.5;
height=6;
set(gcf,'position',[x0,y0,width,height])