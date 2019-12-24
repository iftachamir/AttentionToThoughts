function vars = internal_attention_computation_ValenceAndRelevance(vars)

% Current iteration
ii = vars.ii;

%% Calculate the current mean of selection likelihoods
% Common components across domains
emotionComponent = vars.Emotion(ii-1) * (1 + vars.EmotionalReactivity(ii)); 
contextProportionComponent_valence = 1 + vars.Context(ii);

% Valence likelihood: Neg. / Ntr.
% IA_nominator_valence = mean([vars.WM_valence_mean(ii-1), ...
%     emotionComponent]);
IA_nominator_valence = emotionComponent;
%InternalAttention_mu_valence = IA_nominator_valence / IA_denominator;
InternalAttention_mu_valence = IA_nominator_valence ...
    / contextProportionComponent_valence;

% Task irrelevance: Off/on Task likelihood
IA_nominator_relevance = vars.WM_irrelevance_mean(ii-1);
contextProportionComponent_relevance = vars.WM_irrelevance_mean(ii-1) ...
    + vars.Context(ii);
%InternalAttention_mu_irrelevance = IA_nominator_valence / contextProportion_component;
InternalAttention_mu_irrelevance = IA_nominator_relevance ...
    / contextProportionComponent_relevance;

%% Add Stochastic factor as variation in likelihood 
% sample_num = 1000;
% multi_distr = mvnrnd_trn([.01,.01], [.99,.99], ...
%     [InternalAttention_mu_valence, InternalAttention_mu_irrelevance], ...
%     [vars.StochasticFactor, 0; 0, vars.StochasticFactor], ...
%     sample_num);
%plot(multi_distr(:,1),multi_distr(:,2),'+')

% Valence
pd_valence = makedist(...
    'Normal','mu',InternalAttention_mu_valence, ...
    'sigma',vars.StochasticFactor);
trunc_pd_valence = truncate(pd_valence,0.01,.99);

% irrelevance
pd_irrelevance = makedist(...
    'Normal','mu',InternalAttention_mu_irrelevance, ...
    'sigma',vars.StochasticFactor);
trunc_pd_irrelevance = truncate(pd_irrelevance,0.01,.99);

% Draw a new likelihood from that prob. distribution
vars.InternalAttention.valence(ii) = random(trunc_pd_valence,1,1);
vars.InternalAttention.irrelevance(ii) = random(trunc_pd_irrelevance,1,1);

%% Create a distribution of neg/ntr objects
% Create a matrix representing two dimensions
population_dimension_size = 10;
IA_population = repmat("", ...
    population_dimension_size, population_dimension_size);

% Add negative options
roundIA_valence = round(vars.InternalAttention.valence(ii) * ...
    population_dimension_size);

% Also convert neutral options into negative, relative to proportion of
% task-relevant negative bias
add_neg_portion = floor( (population_dimension_size - roundIA_valence) * ...
    (vars.prop_of_negative_and_task_relevant) );
disp(add_neg_portion)
roundIA_valence = roundIA_valence + add_neg_portion;

%IA_population(1, 1:roundIA_valence) = "neg";

% Add irrelevance options
roundIA_irrelevance = round(vars.InternalAttention.irrelevance(ii) * ...
    population_dimension_size);

% Create matrix
for valence_counter = 1:population_dimension_size
    for irrelevance_counter = 1:population_dimension_size
        % Valence
        if valence_counter <= roundIA_valence
            text = "neg";
        else
            text = "ntr";
        end
        
        % irrelevance
        if irrelevance_counter <= roundIA_irrelevance
            text = text + "_irrelevant";
        else
            text = text + "_relevant";
        end
        
        IA_population(valence_counter, irrelevance_counter) = text;
    end
end


%% RANDOMLY SELECT FROM POPULATION
vector = reshape(IA_population,[1, population_dimension_size^2]);
text = char(randsample(vector,1));
vars.selectedThought.valence(ii) = text(1:3);
vars.selectedThought.irrelevance(ii) = text(5:end);

if vars.selectedThought.valence(ii) == "neg"
    vars.selectedThought_valence_value(ii) = 1;
else
    vars.selectedThought_valence_value(ii) = 0;
end

if vars.selectedThought.irrelevance(ii) == "irrelevant"
    vars.selectedThought_irrelevance_value(ii) = 1;
else
    vars.selectedThought_irrelevance_value(ii) = 0;
end