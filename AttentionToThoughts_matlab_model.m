%% Attention-to-Thoughts (A2T) Simulation code
%

clear all
addpath './functions/'
addpath './functions/exgauss'

%% Set seed
% rng(1)

%% Starting values for the simulations (for first 5 iterations)
v.Context = 5;                                  % Range 1-5
v.StochasticFactor = .1;
v.EmotionalReactivity = -.25;                   % Range -.3 - .3 (values outside this range should produce strange results)
v.CognitiveReactivity = -.25;                   % Range -.3 - .3

v.InternalAttention.valence_bias = 0.5;
v.Emotion = 1;                                  % Range 0-5
v.selectedThought.valence = "ntr";
v.selectedThought.irrelevance = "relevant";
v.WM_valence_mean = .2;
v.WM_irrelevance_mean = .2;
v.WM_valence_sum = 1;                           % Range 0-1
v.WM_irrelevance_sum = 1;

v.prop_of_negative_and_task_relevant = .01;     % This sets the degree to which negative information is task relevant (0 = only neutral is relevant, 1 = only negative is relevant)

v.numOfIterations = 300;                        % Simulate 5 minutes (5 mins * 60 secs)

v.figureY = .85;                                % For visualization


%% Examples of how to run a simulation

%%% E.g. 1 - High context - Low reactivity
% Set values for simulation (see above starting values for possible
% variables that can be pre-set).
v.Context = 4;
v.EmotionalReactivity = -.25;
v.CognitiveReactivity = -.25;

% Title for figure
v.title = "(A) Context: High demand for focused attention";

% Simulate
f1A = simulations(v);

% Visualize simulation
figure(f1A)


%%% E.g. 2 - Low context - Low reactivity
v.Context = 2;
v.EmotionalReactivity = -.25;
v.CognitiveReactivity = -.25;
v.title = "(B) Context: Low demand for focused attention";
f1B = simulations(v);
figure(f1B)

%%% E.g. 3 - High context with 50% task relevant negative information
v.Context = 4;
v.EmotionalReactivity = -.25;
v.CognitiveReactivity = -.25;
v.prop_of_negative_and_task_relevant = .5;
v.title = "High context / 50% task relevant negative information";
f2 = simulations(v);
figure(f2)

