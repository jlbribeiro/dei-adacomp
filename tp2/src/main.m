%% Train/Validation split, normalization and dimensionality reduction
dataset_input_setup;

%% Loading training data
load('../dataset/training_dataset')
P_train = X1_train';
T_train = T1_train';

%% NN training
net = nn_train(P_train, T_train);

%% Loading validation data
load('../dataset/validation_dataset')
P_validation = X1_validation';
T_validation = T1_validation';

%% NN validation
nn_sim(net, P_validation, T_validation);
