%% "Importing" constants and structs
constants_structs

%% Load neural networks' weights
load W_LAM;
load W_Perc;

%% Load validation data
load P_valid.dat;

%% Validate each digit
fprintf('# Digit validation\n');

errors_LAM = 0;
errors_Perc = 0;
for i = 1 : N_DIGITS
    fprintf('## Digit to be classified\t%s\n\n', DIGITS(i));

    for j = 1 : VALIDATION_SAMPLES_PER_DIGIT
        
        P_i = P_valid(:, (i - 1) * VALIDATION_SAMPLES_PER_DIGIT + j);

        A_LAM = W_LAM * P_i;
        A_Perc = sim(W_Perc, P_i);

        [~, digit_i_LAM] = max(A_LAM);
        [~, digit_i_Perc] = max(A_Perc);

        errors_LAM = errors_LAM + (digit_i_LAM ~= i);
        errors_Perc = errors_Perc + (digit_i_Perc ~= i);

        fprintf('LAM digit\t\t\t%s\n', DIGITS(digit_i_LAM));
        fprintf('Perceptron digit\t\t%s\n\n', DIGITS(digit_i_Perc));
    end

    fprintf('\n');
end

fprintf('# Classification results\n\n');
fprintf('Number of wrongly classified digits by LAM:\t\t%d\n', errors_LAM);
fprintf('Number of wrongly classified digits by Perceptron:\t%d\n', errors_Perc);

%% Bar plot to show on the report
number_of_samples = size(P_valid, 2);

y_Values = [number_of_samples - errors_LAM, number_of_samples - errors_Perc] / number_of_samples * 100; % y_Values contains the percentage of well-classified digits
x_Values = [0 1];

bar(x_Values, y_Values);
axis([-1 2 0 100]);
set(gca, 'XTickLabel', {'LAM', 'Perceptron'});
title('Efficiency of digit recognition using LAM and Perceptron');

xlabel('Approach used to classify the digits');
ylabel('Percentage of well-classified digits (%)');