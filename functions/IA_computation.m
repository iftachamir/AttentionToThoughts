function vars = IA_computation(vars)

% Current iteration
ii = vars.ii;

%% Calculate the current mean of selection likelihoods

%%% Tau
% Common components across domains
emotionComponent = vars.Emotion(ii-1) * ...
    (1 + vars.EmotionalReactivity(ii));

formula_WM_and_affect_parts = sum([vars.WM_valence_sum(ii-1), ...
    emotionComponent]);

formula_context = 2 * (vars.Context(ii) ^ 2);

IA_tau = formula_WM_and_affect_parts / formula_context;

%%% Mu
IA_mu = vars.prop_of_negative_and_task_relevant;

%%% Sigma
IA_sig = vars.StochasticFactor;


%% Draw a new valence bias likelihood from the probability distribution

% Draw a random sample
r = exgauss_rnd(IA_mu, IA_sig, IA_tau);

% Convert with tanh
vars.InternalAttention.valence_bias(ii) = tanh(r);

% Constrain range between 0 and 1
if vars.InternalAttention.valence_bias(ii) < 0
    vars.InternalAttention.valence_bias(ii) = 0;
elseif vars.InternalAttention.valence_bias(ii) > 1
    vars.InternalAttention.valence_bias(ii) = 1;
end


%% Create a distribution of neg/ntr objects
% This represents the population of internal stimuli competing for
% selection into WM. From this population a single representation will be
% sampled.

% Create a vector representing two dimensions
population_dimension_size = 10;
IA_population = repmat("", population_dimension_size, 1);

% Add negative options
roundIA_valence = round(vars.InternalAttention.valence_bias(ii) * ...
    population_dimension_size);

% Populate text vector according to 
for valence_counter = 1:population_dimension_size
    % Valence
    if valence_counter <= roundIA_valence
        text = "neg";
    else
        text = "ntr";
    end
    
    IA_population(valence_counter) = text;
end


%% RANDOMLY SELECT FROM POPULATION

% Sample
text = randsample(IA_population,1);

% Add to simulation vectors
vars.selectedThought.valence(ii) = text;

if vars.selectedThought.valence(ii) == "neg"
    vars.selectedThought_valence_value(ii) = 1;
else
    vars.selectedThought_valence_value(ii) = 0;
end
