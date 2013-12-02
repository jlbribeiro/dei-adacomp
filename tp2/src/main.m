constants;

%% Train/Validation split, normalization and dimensionality reduction
dataset_input_setup;

%% Accumulators
percCorrect_acc = 0;
sensibility_acc = 0;
specificity_acc = 0;

disp(char('-' * ones(1, N_RUNS)));
for i = 1 : N_RUNS
    fprintf('.');

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
    [Y, percCorrect, sensibility, specificity] = nn_sim(net, P_validation, T_validation);

    percCorrect_acc = percCorrect_acc + percCorrect;
    sensibility_acc = sensibility_acc + sensibility;
    specificity_acc = specificity_acc + specificity;
end

percCorrect_avg = percCorrect_acc / N_RUNS;
sensibility_avg = sensibility_acc / N_RUNS;
specificity_avg = specificity_acc / N_RUNS;

fprintf('\n')
fprintf('TRAINING_METHOD = %s\n', TRAINING_METHOD);
fprintf('LEARNING_RATE = %.5f\n', LEARNING_RATE);
fprintf('N_HIDDEN_NEURONS = %d\n', N_HIDDEN_NEURONS);
fprintf('N_FEATURES = %d\n', N_FEATURES);
fprintf('N_EPOCHS = %d\n', N_EPOCHS);
fprintf('\n');
fprintf('performance = %.3f\n', percCorrect_avg);
fprintf('sensibility = %.3f\n', sensibility_avg);
fprintf('specificity = %.3f\n', specificity_avg);
fprintf('\n');
fprintf('Plotting: performance_plot(%f, %f, %f)\n', percCorrect_avg, sensibility_avg, specificity_avg);
fprintf('===\n\n');

if DEBUG
    performance_plot(percCorrect_avg, sensibility_avg, specificity_avg);
end

%% TODO: remove
sound(randn(4096, 1), 8192)