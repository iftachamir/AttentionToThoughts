clear all
addpath './functions/'

%% Starting values
v.Context = .5;
v.InternalAttention.valence = 0.5;
v.InternalAttention.irrelevance = 0.5;
v.Emotion = 0.2;
v.EmotionalReactivity = .5;
v.CognitiveReactivity = .5;
v.StochasticFactor = .1;
v.numOfIterations = 300;
v.selectedThought.valence = "ntr";
v.selectedThought.irrelevance = "relevant";
v.WM_valence_mean = .2;
v.WM_irrelevance_mean = .2;
v.prop_of_negative_and_task_relevant = .01;
v.figureY = .85;


% High context
v.Context = .8;
v.title = "(A) Context: High demand for focused attention";
f1A = simulations(v);
figure(f1A)

% Low context
v.Context = 0.2;
v.title = "(B) Context: Low demand for focused attention";
f1B = simulations(v);
figure(f1B)

%%%
% High context with 50% task relevant negative information
v.Context = .8;
v.prop_of_negative_and_task_relevant = .5;
v.title = "High context / 50% task relevant negative information";
f2 = simulations(v);
figure(f2)

%%%
% Low context / Moderate Reactivity
v.Context = .2;
v.EmotionalReactivity = .5;
v.CognitiveReactivity = .5;
v.prop_of_negative_and_task_relevant = .01;
v.title = "(A) Low context / Moderate Reactivity";
v.figureY = .15;
f3A = simulations(v);
figure(f3A)

% Low context / High Reactivity
v.Context = .2;
v.EmotionalReactivity = .8;
v.CognitiveReactivity = .8;
v.prop_of_negative_and_task_relevant = .01;
v.title = "(B) Low context / High Reactivity";
v.figureY = .15;
f3B = simulations(v);
figure(f3B)

%%%

% High context / High Reactivity
v.Context = .8;
v.EmotionalReactivity = .8;
v.CognitiveReactivity = .8;
v.prop_of_negative_and_task_relevant = .01;
v.title = "(A) High context / High Reactivity";
f4A = simulations(v);
figure(f4A)

% High context with 50% task relevant negative information
v.Context = .8;
v.EmotionalReactivity = .8;
v.CognitiveReactivity = .8;
v.prop_of_negative_and_task_relevant = .5;
v.title = "(B) High context / High Reactivity / 50% task relevant negative information";
f4B = simulations(v);
figure(f4B)

% Low context / High Reactivity / High initial affect
v.Context = .2;
v.EmotionalReactivity = .8;
v.CognitiveReactivity = .8;
v.Emotion = .8;
v.title = "Low context / High Reactivity / High initial affect";
f5 = simulations(v);
figure(f5)

% % High then low context
% highContext = repmat(.8, 1, v.numOfIterations / 2);
% lowContext = repmat(.2, 1, v.numOfIterations / 2);
% v.Context = [highContext, lowContext];
% v.title = "High context";
% f1 = simulations(v);
% figure(f1)
