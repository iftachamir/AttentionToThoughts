function f = simulations(v)

Context = v.Context;
InternalAttention = v.InternalAttention;
Emotion = v.Emotion;
EmotionalReactivity = v.EmotionalReactivity;
CognitiveReactivity = v.CognitiveReactivity;
StochasticFactor = v.StochasticFactor;
numOfIterations = v.numOfIterations;

% Simulate
for ii = 2:numOfIterations
    
    % Context
    Context(ii) = Context(1);
    
    % Emotional Reactivity
    EmotionalReactivity(ii) = EmotionalReactivity(1);
    
    % Cognitive Reactivity
    CognitiveReactivity(ii) = CognitiveReactivity(1);
    
    % Internal Attention
    IA_nominator = ( (1 + Emotion(ii-1)) * (1 + EmotionalReactivity(ii)) ) ...
        / 4;
    IA_denominator = IA_nominator + Context(ii);
    
    InternalAttention_mu = IA_nominator / IA_denominator;
    InternalAttention(ii) = normrnd(InternalAttention_mu, ...
        StochasticFactor);
    if InternalAttention(ii)>1
        InternalAttention(ii)=1;
    elseif InternalAttention(ii)<0
        InternalAttention(ii)=0;
    end
    
    % Emotion
    subEmotion = (1 + CognitiveReactivity(ii)) * ...
        InternalAttention(ii);
    Emotion(ii) = subEmotion / 2;
    %Emotion(ii) = CognitiveReactivity(ii) * InternalAttention(ii-1);
    if Emotion(ii)>1
        Emotion(ii)=1;
    elseif Emotion(ii)<0
        Emotion(ii)=0;
    end
end

f = figure("Visible",false);
x = 1:numOfIterations;
% smoothEmotion = smooth(Emotion,30);
% smoothAttention = smooth(InternalAttention,30);
smoothEmotion = smoothdata(Emotion, 'gaussian', 10);
smoothAttention = smoothdata(InternalAttention, 'gaussian', 10);
yyaxis left
hold on
p1 = plot(x, InternalAttention, '--b', ...
    x, Emotion, '--r');
p2 = plot(x, smoothAttention, '-b', ...
    x, smoothEmotion, '-r', 'LineWidth', 2);
hold off

legend(["Attention"; "Emotion"])
ylim([0 1])
title(v.title)
xlabel('Time (secs)')
ylabel('Selection bias')

yyaxis right
ylabel('Negative affect')

% txt = {'\underline{Initial values:}', ...
%     ['Context = ' num2str(v.Context) '*'], ...
%     ['Selection bias = ' num2str(v.InternalAttention)], ...
%     ['Affect = ' num2str(v.Emotion)], ...
%     ['Cognitive reactivity = ' num2str(v.CognitiveReactivity) '*'], ...
%     ['Emotional reactivity = ' num2str(v.EmotionalReactivity) '*']};
% text(0,-.3,txt, 'Interpreter', 'latex')
% %annotation('textbox', [-3, -3, 1, .5], 'string', txt)

fname = ['./figures/' char(erase(v.title, '/')) '.svg'];
saveas(f, fname, 'svg')