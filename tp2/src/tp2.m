%% FIXME
%% Dimensionality Reduction will not use the same features used during training, throwing an error (dimensions mismatch)

%% Contest data validation
load('../dataset/test_dataset'); %% loads X2

%% Contest data should be normalized
P_contest = dataset_normalize_input(X2);
P_contest = dataset_dimensionality_reduction(P_contest);

P_contest = P_contest';

%% Load NN
load('net')

Y = nn_sim(net, P_contest);
Y = round(Y);