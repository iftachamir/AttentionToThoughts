function f = simulations(v)

%% Set the first 5 time points

% Context
v.Context = v.Context;

% Valence
v.InternalAttention.valence_bias(1:5) = v.InternalAttention.valence_bias;

% Emotion
v.Emotion(1:5) = v.Emotion;

% Reactivity levels
v.EmotionalReactivity(1:5) = v.EmotionalReactivity;
v.CognitiveReactivity(1:5) = v.CognitiveReactivity;

% Initial thought valences and their sums and means (first 5 time points)
v.selectedThought.valence = ["ntr", "ntr", "ntr", "ntr", "neg"];
v.selectedThought_valence_value = [0, 0, 0, 0, 1];
v.WM_valence_mean(1:5) = v.WM_valence_mean;
v.WM_valence_sum(1:5) = v.WM_valence_sum;


%%% Simulate
for ii = 6:v.numOfIterations
    
    %% Time
    v.ii = ii;
    
    %% Context
    v.Context(ii) = v.Context(1);       % This allows for altering context during simulation if desired
    
    %% Emotional Reactivity
    v.EmotionalReactivity(ii) = v.EmotionalReactivity(1);       % Emotional reactivity is conceputalized a static trait, and so remains similar across simulation timepoints
    
    %% Cognitive Reactivity
    v.CognitiveReactivity(ii) = v.CognitiveReactivity(1);       % Cognitive reactivity is conceputalized a static trait
    
    %% Internal Attention
    v = IA_computation(v);
    
    %% WM storage
    % Sum of previous attended thoughts
    WM_valence = v.selectedThought_valence_value(ii-4:ii);
    v.WM_valence_sum(ii) = sum(WM_valence);
    
    %% Emotion
    v.Emotion(ii) = (1 + v.CognitiveReactivity(ii)) * ...
        v.WM_valence_sum(ii);
    if v.Emotion(ii) > 5
        v.Emotion(ii) = 5;
    end

end

%% Visuals
f = figure_2d(v);

fname = ['./figures/' char(erase(v.title, {'/', ':'})) '.fig'];
saveas(f, fname, 'fig')