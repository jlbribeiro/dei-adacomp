%% Constants
DEBUG = true;

TRAINING_RATIO = 0.7;
VALIDATION_RATIO = 1 - TRAINING_RATIO;

N_RUNS = 30;

%% Training
N_HIDDEN_NEURONS = 15;    % Value to be fine-tuned
LEARNING_RATE    = 0.001; % Value to be fine-tuned
N_EPOCHS         = 100;   % Value to be fine-tuned
TRAINING_METHOD  ='trainlm';