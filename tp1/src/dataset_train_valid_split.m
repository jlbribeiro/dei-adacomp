%% Constants
DIGITS = '0123456789+-=';
N_DIGITS = length(DIGITS);

TRAINING_SAMPLES_PER_DIGIT = 7;
VALIDATION_SAMPLES_PER_DIGIT = 3;
SAMPLES_PER_DIGIT = TRAINING_SAMPLES_PER_DIGIT + VALIDATION_SAMPLES_PER_DIGIT;

%% Initializing digit size struct
digit_size = struct();
digit_size.width = 5;
digit_size.height = 5;

%% Load original dataset
load P_dataset.dat;

%% Split dataset into training and validation datasets
P_train = zeros(digit_size.width * digit_size.height, N_DIGITS * TRAINING_SAMPLES_PER_DIGIT);
P_valid = zeros(digit_size.width * digit_size.height, N_DIGITS * VALIDATION_SAMPLES_PER_DIGIT);

for i = 1 : N_DIGITS; 
    % Shuffle i digit indexes on the dataset
    P_digit_i_indexes = (i - 1) * SAMPLES_PER_DIGIT + randsample(SAMPLES_PER_DIGIT, SAMPLES_PER_DIGIT);

    % Pick the dataset's digit patterns on a shuffled manner, in order to obtain different training and validation datasets
    P_digit_i = P_dataset(:, P_digit_i_indexes);

    P_digit_i_train = P_digit_i(:, 1 : TRAINING_SAMPLES_PER_DIGIT);
    P_digit_i_valid = P_digit_i(:, TRAINING_SAMPLES_PER_DIGIT + 1 : SAMPLES_PER_DIGIT);

    % Avoid concatenation and use attribution
    P_train(:, (i - 1) * TRAINING_SAMPLES_PER_DIGIT + 1 : i * TRAINING_SAMPLES_PER_DIGIT) = P_digit_i_train;
    P_valid(:, (i - 1) * VALIDATION_SAMPLES_PER_DIGIT + 1 : i * VALIDATION_SAMPLES_PER_DIGIT) = P_digit_i_valid;
end;

save('P_train.dat', 'P_train', '-ascii');
save('P_valid.dat', 'P_valid', '-ascii');
