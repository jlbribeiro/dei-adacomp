%% Contest data validation
load('dataset2'); %% loads X2

%% Contest data should be normalized
X2 = dataset_normalize_input(X2);
X2 = dataset_dimensionality_reduction(X2, N_FEATURES);

X2 = X2';

%% Load NN
load('best_net');

Y2 = nn_sim(net, X2);
Y2 = round(Y2);

save('Y2.dat', 'Y2');