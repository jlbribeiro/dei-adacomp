%% "Importing" constants and structs
constants

%% Load original dataset
load('../dataset/train_and_validation_dataset.mat')

number_of_patterns = size(X1,1);
number_of_features = size(X1,2);
TRAINING_SAMPLES = round(number_of_patterns*TRAINING_RATIO);
VALIDATION_SAMPLES = number_of_patterns - TRAINING_SAMPLES;

%% Split dataset into training and validation datasets
normalizar=1;
   
%Normalizacao [0..1]
if normalizar
   for i=1:size(X1,1)
       X1(i,:)=X1(i,:)/max(X1(i,:));
   end
end

%model = pca( X1 );
%model.eigval
[coefs,scores,latent] = princomp(X1);
cumsum(latent)./sum(latent)
X1 = scores(:,1:4);

% Shuffle i digit indexes on the dataset
shuffled_patterns_indexes = randsample(number_of_patterns,number_of_patterns);

% Pick the dataset's digit patterns on a shuffled manner, in order to obtain different training and validation datasets
shuffled_patterns = shuffled_patterns_indexes(shuffled_patterns_indexes,:);

X1_train = X1(1 : TRAINING_SAMPLES, :);
T1_train = T1(1 : TRAINING_SAMPLES, :);
X1_validation = X1(TRAINING_SAMPLES + 1 : number_of_patterns, :);
T1_validation = T1(TRAINING_SAMPLES + 1 : number_of_patterns, :);

save('../dataset/training_dataset', 'X1_train', 'T1_train', 'caracteristicas_names');
save('../dataset/validation_dataset', 'X1_validation', 'T1_validation', 'caracteristicas_names');
