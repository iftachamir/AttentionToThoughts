function f = simulations(v)

v.Context = v.Context;
v.InternalAttention.valence(1:5) = v.InternalAttention.valence;
v.InternalAttention.irrelevance(1:5) = v.InternalAttention.irrelevance;
v.Emotion(1:5) = v.Emotion;
v.EmotionalReactivity(1:5) = v.EmotionalReactivity;
v.CognitiveReactivity(1:5) = v.CognitiveReactivity;
v.selectedThought.valence = ["ntr", "ntr", "ntr", "ntr", "neg"];
v.selectedThought_valence_value = [0, 0, 0, 0, 1];
v.selectedThought.irrelevance = ...
    ["relevant", "relevant", "relevant", "relevant", "irrelevant"];
v.selectedThought_irrelevance_value = [0, 0, 0, 0, 1];
v.WM_valence_mean(1:5) = v.WM_valence_mean;
v.WM_irrelevance_mean(1:5) = v.WM_irrelevance_mean;


%%% Simulate
for ii = 6:v.numOfIterations
    
    v.ii = ii;
    
    %% Context
    v.Context(ii) = v.Context(1);
    
    %% Emotional Reactivity
    v.EmotionalReactivity(ii) = v.EmotionalReactivity(1);
    
    %% Cognitive Reactivity
    v.CognitiveReactivity(ii) = v.CognitiveReactivity(1);
    
    %% Internal Attention
    v = internal_attention_computation_ValenceAndRelevance_1(v);
    
    %% WM storage
    % Sum of previous attended thoughts
    WM_valence = v.selectedThought_valence_value(ii-3:ii);
    v.WM_valence_mean(ii) = mean(WM_valence);
    
    WM_irrelevance = v.selectedThought_irrelevance_value(ii-3:ii);
    v.WM_irrelevance_mean(ii) = mean(WM_irrelevance);
    
    %% Emotion
    v.Emotion(ii) = v.CognitiveReactivity(ii) * v.WM_valence_mean(ii);

end

%% Visuals
f = figure_2d(v);
%f = figure_3d(v);

fname = ['./figures/' char(erase(v.title, {'/', ':'})) '.fig'];
saveas(f, fname, 'fig')