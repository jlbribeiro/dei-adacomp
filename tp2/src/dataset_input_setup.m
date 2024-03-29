%% "Importing" constants and structs
constants;

%% Load original dataset
load('../dataset/train_and_validation_dataset.mat');

[n_patterns, n_features] = size(X1);
TRAINING_SAMPLES = round(n_patterns * TRAINING_RATIO);
VALIDATION_SAMPLES = n_patterns - TRAINING_SAMPLES;

%% Input normalization and dimensionality reduction
if INPUT_NORMALIZATION
    X1 = dataset_normalize_input(X1);
end

X1 = dataset_dimensionality_reduction(X1, N_FEATURES);

%% Shuffle before split
shuffled_patterns_indexes = randsample(n_patterns, n_patterns);

X1 = X1(shuffled_patterns_indexes, :);
T1 = T1(shuffled_patterns_indexes, :);

%% Split dataset into training and validation datasets
X1_train = X1(1 : TRAINING_SAMPLES, :);
T1_train = T1(1 : TRAINING_SAMPLES, :);
X1_validation = X1(TRAINING_SAMPLES + 1 : n_patterns, :);
T1_validation = T1(TRAINING_SAMPLES + 1 : n_patterns, :);

save('../dataset/training_dataset', 'X1_train', 'T1_train', 'caracteristicas_names');
save('../dataset/validation_dataset', 'X1_validation', 'T1_validation', 'caracteristicas_names');
