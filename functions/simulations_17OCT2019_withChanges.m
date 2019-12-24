function f = simulations(v)

Context = v.Context;
InternalAttention(1:5) = v.InternalAttention;
Emotion(1:5) = v.Emotion;
EmotionalReactivity(1:5) = v.EmotionalReactivity;
CognitiveReactivity(1:5) = v.CognitiveReactivity;
StochasticFactor = v.StochasticFactor;
numOfIterations = v.numOfIterations;
selectedThought = ["ntr", "ntr", "ntr", "ntr", "neg"];
selectedThought_value = [0, 0, 0, 0, 1];
WM_mean(1:5) = v.WM;

%%% Simulate
for ii = 6:numOfIterations
    
    %% Context
    Context(ii) = Context(1);
    
    %% Emotional Reactivity
    EmotionalReactivity(ii) = EmotionalReactivity(1);
    
    %% Cognitive Reactivity
    CognitiveReactivity(ii) = CognitiveReactivity(1);
    
    %% Internal Attention
%     IA_nominator = ( InternalAttention(ii-1) ...
%         * (1 + Emotion(ii-1)) ...
%         * (1 + EmotionalReactivity(ii)) ) ...
%         / 4;
    IA_nominator = mean([ WM_mean(ii-1), ...
        ( Emotion(ii-1) * ...
        (1 + EmotionalReactivity(ii)) ) ]);
    IA_denominator = 1 + Context(ii);
    
    InternalAttention_mu = IA_nominator / IA_denominator;
    
    %InternalAttention(ii) = IA_nominator / IA_denominator;
    %InternalAttention(ii) = IA_nominator / (1 + Context(ii));
    
    pd = makedist(...
        'Normal','mu',InternalAttention_mu,'sigma',StochasticFactor);
    trunc_pd = truncate(pd,0,1);
    
    InternalAttention(ii) = random(trunc_pd,1,1);
%     InternalAttention(ii) = ...
%         normrnd(InternalAttention_mu, StochasticFactor);
%     
%     if InternalAttention(ii)>.9
%         InternalAttention(ii)=.9;
%     elseif InternalAttention(ii)<0.1
%         InternalAttention(ii)=0.1;
%     end
    
    % Create a distribution of neg/ntr objects
    IA_population = repmat("ntr",1,10);                    % Start with all neutral
    roundIA = round(InternalAttention(ii)*10);
    IA_population(1:roundIA) = repmat("neg",1,roundIA);    % Add negative options
    selectedThought(ii) = randsample(IA_population,1);
    
    % RANDOMLY SELECT FROM POPULATION
    if selectedThought(ii) == "neg"
        selectedThought_value(ii) = 1;
    else
        selectedThought_value(ii) = 0;
    end
    
    %% WM storage
    WM = selectedThought_value(ii-4:ii);
    
    %WM_mean(ii) = sum(WM .* [5 4 3 2 1]) / 15;
    WM_mean(ii) = mean(WM);
    
    %% Emotion
    % Sum of previous attended thoughts
    WM_mean(ii) = mean(WM);
    
    subEmotion = CognitiveReactivity(ii) * ...
        WM_mean(ii);
    Emotion(ii) = subEmotion;
    %Emotion(ii) = CognitiveReactivity(ii) * InternalAttention(ii-1);
    if Emotion(ii)>1
        Emotion(ii)=1;
    elseif Emotion(ii)<0
        Emotion(ii)=0;
    end
end

set( gca                       , ...
    'FontName'   , 'Times New Roman' );

f = figure("Visible",false);
x = 1:numOfIterations;
% smoothEmotion = smooth(Emotion,30);
% smoothAttention = smooth(InternalAttention,30);
smoothEmotion = smoothdata(Emotion, 'gaussian', 10);
smoothAttention = smoothdata(InternalAttention, 'gaussian', 10);
yyaxis left
hold on
% p1 = plot(x, InternalAttention, '--b', ...
%     x, Emotion, '--r');
p2 = plot(x, smoothAttention, '-k', ...
    x, smoothEmotion, '-r', 'LineWidth', 1);

% Add dots reflecting thought type
a = max([smoothAttention, smoothEmotion]) + .05;
b = a + .05;
r = (b-a).*rand(v.numOfIterations,1) + a;
s = gscatter(x, r, selectedThought, ...
    'br','.',7);
hold off

legend(["Attention"; "Emotion"; "Neutral Thought"; "Negative Thought"])
ylim([-.1 1.1])
title(v.title)
xlabel('Time (secs)')
ylabel('Selection bias')

yyaxis right
ylabel('Negative affect')

f.Units = 'centimeters';
x0=10;
y0=10;
width=16.5;
height=6;
set(gcf,'position',[x0,y0,width,height])

% txt = {'\underline{Initial values:}', ...
%     ['Context = ' num2str(v.Context) '*'], ...
%     ['Selection bias = ' num2str(v.InternalAttention)], ...
%     ['Affect = ' num2str(v.Emotion)], ...
%     ['Cognitive reactivity = ' num2str(v.CognitiveReactivity) '*'], ...
%     ['Emotional reactivity = ' num2str(v.EmotionalReactivity) '*']};
% text(0,-.3,txt, 'Interpreter', 'latex')
% %annotation('textbox', [-3, -3, 1, .5], 'string', txt)

fname = ['./figures/' char(erase(v.title, '/')) '.fig'];
saveas(f, fname, 'fig')