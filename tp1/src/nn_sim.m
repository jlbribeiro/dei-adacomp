%% Constants
DIGITS = '0123456789+-=';
N_DIGITS = length(DIGITS);

VALIDATION_SAMPLES_PER_DIGIT = 3;

%% Initializing digit size struct
digit_size = struct();
digit_size.width = 5;
digit_size.height = 5;

%% Load neural networks' weights
load W_LAM;
load W_Perc;

%% Load validation data
load P_valid.dat;

%% Validate each digit
fprintf('# Digit validation\n');

errors_LAM = 0;
errors_Perc = 0;
for i = 1 : N_DIGITS;
    fprintf('## Digit to be classified\t%s\n\n', DIGITS(i));

    for j = 1 : VALIDATION_SAMPLES_PER_DIGIT;
        P_i = P_valid(:, (i - 1) * VALIDATION_SAMPLES_PER_DIGIT + j);

        A_LAM = W_LAM * P_i;
        A_Perc = sim(W_Perc, P_i);

        [~, digit_i_LAM] = max(A_LAM);
        [~, digit_i_Perc] = max(A_Perc);

        errors_LAM = errors_LAM + (digit_i_LAM ~= i);
        errors_Perc = errors_Perc + (digit_i_Perc ~= i);

        fprintf('LAM digit\t\t\t%s\n', DIGITS(digit_i_LAM));
        fprintf('Perceptron digit\t\t%s\n\n', DIGITS(digit_i_Perc));
    end;

    fprintf('\n');
end;

fprintf('# Classification results\n\n');
fprintf('Number of wrongly classified digits by LAM:\t\t%d\n', errors_LAM);
fprintf('Number of wrongly classified digits by Perceptron:\t%d\n', errors_Perc);