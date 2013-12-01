%% "Importing" constants and structs
constants;

%% Load original dataset
load('../dataset/train_and_validation_dataset.mat');

[number_of_patterns, number_of_features] = size(X1);
TRAINING_SAMPLES = round(number_of_patterns * TRAINING_RATIO);
VALIDATION_SAMPLES = number_of_patterns - TRAINING_SAMPLES;

%% Input normalization and dimensionality reduction
X1 = dataset_normalize_input(X1);
X1 = dataset_dimensionality_reduction(X1);

%% Shuffle before split
%% TODO!

%% Split dataset into training and validation datasets
X1_train = X1(1 : TRAINING_SAMPLES, :);
T1_train = T1(1 : TRAINING_SAMPLES, :);
X1_validation = X1(TRAINING_SAMPLES + 1 : number_of_patterns, :);
T1_validation = T1(TRAINING_SAMPLES + 1 : number_of_patterns, :);

save('../dataset/training_dataset', 'X1_train', 'T1_train', 'caracteristicas_names');
save('../dataset/validation_dataset', 'X1_validation', 'T1_validation', 'caracteristicas_names');
