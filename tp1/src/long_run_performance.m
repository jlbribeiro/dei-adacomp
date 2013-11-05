%% "Importing" constants and structs
constants_structs

%% Validate each digit
total_errors_LAM = 0;
total_errors_Perc = 0;

%% Keeping a reference for the best neural networks
best_W_LAM = 0;
best_W_Perc = 0;

%% Initialize the neural networks last error counting as infinity
best_LAM_performance = inf;
best_Perc_performance = inf;

for k = 1 : N_RUNS
    dataset_digit_merger
    dataset_train_valid_split

    % Load training and validation data
    load P_train.dat;
    load P_valid.dat;

    % Training a Perceptron
    W_Perc = newp(P_train, T);
    W_Perc.trainParam.showWindow = false;
    W_Perc = train(W_Perc, P_train, T);

    % Training an Linear Associative Memory
    W_LAM = T * pinv(P_train);

    errors_LAM = 0;
    errors_Perc = 0;
    for i = 1 : N_DIGITS
        for j = 1 : VALIDATION_SAMPLES_PER_DIGIT

            P_i = P_valid(:, (i - 1) * VALIDATION_SAMPLES_PER_DIGIT + j);

            A_LAM = W_LAM * P_i;
            A_Perc = sim(W_Perc, P_i);

            [~, digit_i_LAM] = max(A_LAM);
            [~, digit_i_Perc] = max(A_Perc);

            errors_LAM = errors_LAM + (digit_i_LAM ~= i);
            errors_Perc = errors_Perc + (digit_i_Perc ~= i);

            if errors_LAM < best_LAM_performance
                best_LAM_performance = errors_LAM;
                best_W_LAM = W_LAM;
            end

            if errors_Perc < best_Perc_performance
                best_Perc_performance = errors_Perc;
                best_W_Perc = W_Perc;
            end    
        end
    end

    total_errors_LAM = total_errors_LAM + errors_LAM;
    total_errors_Perc = total_errors_Perc + errors_Perc;
end

fprintf('# Classification results\n\n');
fprintf('Number of wrongly classified digits by LAM:\t\t%d\n', total_errors_LAM);
fprintf('Number of wrongly classified digits by Perceptron:\t%d\n', total_errors_Perc);

%% Average performance
avg_errors_LAM = total_errors_LAM / N_RUNS;
avg_errors_Perc = total_errors_Perc / N_RUNS;

%% Bar plot to show on the report
number_of_samples = size(P_valid, 2);

y_Values = [number_of_samples - avg_errors_LAM, number_of_samples - avg_errors_Perc] / number_of_samples * 100; % y_Values contains the percentage of well-classified digits
x_Values = [0 1];

bar(x_Values, y_Values);
axis([-1 2 0 100]);
set(gca, 'XTickLabel', {'LAM', 'Perceptron'});
title('Average efficiency of digit recognition using LAM and Perceptron over 30 runs');

xlabel('Approach used to classify the digits');
ylabel('Percentage of well-classified digits over 30 runs (%)');