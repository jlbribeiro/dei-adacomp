%% Constants
DEBUG = true;

TRAINING_RATIO = 0.7;
VALIDATION_RATIO = 1 - TRAINING_RATIO;

N_RUNS = 30;

%% Training
TRAINING_METHOD     = 'trainlm'; % Value to be fine-tuned ['trainlm', 'traingd']
LEARNING_RATE       = 1e-4;      % Value to be fine-tuned [1e-3, 1e-4, 1e-5]    (N_HIDDEN_NEURONS = 5, N_FEATURES = 4)
N_HIDDEN_NEURONS    = 5;         % Value to be fine-tuned [2, 5, 8, 10]         (best LEARNING_RATE, N_FEATURES = 4)
N_FEATURES          = 6;         % Value to be fine-tuned [2, 4, 6]             (best LEARNING_RATE, best N_HIDDEN_NEURONS)
N_EPOCHS            = 100;        % Value to be fine-tuned [30, 50, 100]         (best LEARNING_RATE, best N_HIDDEN NEURONS, best N_FEATURES)
INPUT_NORMALIZATION = true;      % Value to be fine-tuned [true, false]
GOAL                = 1e-6;      % Value to be fine-tuned [1e-2, 1e-4, 1e-6]