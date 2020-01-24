clear all
addpath './functions/'
addpath './functions/exgauss'

%% Starting values
v.Context = 5;

v.InternalAttention.valence = 0.5;
v.InternalAttention.irrelevance = 0.5;

v.Emotion = 1;                                  % Range 0-1
v.StochasticFactor = .1;
v.numOfIterations = 300;

v.selectedThought.valence = "ntr";
v.selectedThought.irrelevance = "relevant";

v.WM_valence_mean = .2;
v.WM_irrelevance_mean = .2;

v.WM_valence_sum = 1;                           % Range 0-1
v.WM_irrelevance_sum = 1;

v.prop_of_negative_and_task_relevant = .01;
v.figureY = .85;


% High context - Low reactivity
v.Context = 4;
v.EmotionalReactivity = -.25;
v.CognitiveReactivity = -.25;
v.title = "(A) Context: High demand for focused attention";
f1A = simulations(v);
figure(f1A)

% Low context - Low reactivity
v.Context = 2;
v.EmotionalReactivity = -.25;
v.CognitiveReactivity = -.25;
v.title = "(B) Context: Low demand for focused attention";
f1B = simulations(v);
figure(f1B)

%%%
% High context with 50% task relevant negative information
v.Context = 4;
v.EmotionalReactivity = -.25;
v.CognitiveReactivity = -.25;
v.prop_of_negative_and_task_relevant = .5;
v.title = "High context / 50% task relevant negative information";
f2 = simulations(v);
figure(f2)

%%%
% Low context / Moderate Reactivity
v.Context = 2;
v.EmotionalReactivity = 0;
v.CognitiveReactivity = 0;
v.prop_of_negative_and_task_relevant = .01;
v.title = "(A) Low context / Moderate Reactivity";
v.figureY = .15;
f3A = simulations(v);
figure(f3A)

% Low context / High Reactivity
v.Context = 2;
v.EmotionalReactivity = .35;
v.CognitiveReactivity = .35;
v.prop_of_negative_and_task_relevant = .01;
v.title = "(B) Low context / High Reactivity";
v.figureY = .15;
f3B = simulations(v);
figure(f3B)

%%%

% Moderate context / High Reactivity
v.Context = 3;
v.EmotionalReactivity = .35;
v.CognitiveReactivity = .35;
v.prop_of_negative_and_task_relevant = .01;
v.title = "(A) Moderate context / High Reactivity";
f4A = simulations(v);
figure(f4A)

% High context / High Reactivity
v.Context = 4;
v.EmotionalReactivity = .35;
v.CognitiveReactivity = .35;
v.prop_of_negative_and_task_relevant = .01;
v.title = "(A) High context / High Reactivity";
f5A = simulations(v);
figure(f5A)

% High context, high reactivity, with 50% task relevant negative information
v.Context = 4;
v.EmotionalReactivity = .35;
v.CognitiveReactivity = .35;
v.prop_of_negative_and_task_relevant = .5;
v.title = "(B) High context / High Reactivity / 50% task relevant negative information";
f4B = simulations(v);
figure(f4B)

% Low context / High Reactivity / High initial affect
v.Context = 2;
v.EmotionalReactivity = .35;
v.CognitiveReactivity = .35;
v.Emotion = .8;
v.title = "Low context / High Reactivity / High initial affect";
f5 = simulations(v);
figure(f5)

