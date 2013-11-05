%% "Importing" constants and structs
constants_structs

%% Load training data
load P_train.dat;

T = zeros(N_DIGITS, TRAINING_SAMPLES_PER_DIGIT);
for i = 1 : N_DIGITS;
    T(i, (i - 1) * TRAINING_SAMPLES_PER_DIGIT + 1 : i * TRAINING_SAMPLES_PER_DIGIT) = ones(1, TRAINING_SAMPLES_PER_DIGIT);
end;

%% Training an Linear Associative Memory
W_LAM = T * pinv(P_train);

save W_LAM W_LAM;

%% Training a Perceptron
W_Perc = newp(P_train, T);
W_Perc.trainParam.showWindow = false;
W_Perc = train(W_Perc, P_train, T);

save W_Perc W_Perc;

%% Verifying the LAM training
A_LAM = W_LAM * P_train;
[~, class_LAM] = max(A_LAM);

A_LAM = zeros(size(A_LAM));
for i = 1 : N_DIGITS * TRAINING_SAMPLES_PER_DIGIT
    A_LAM(class_LAM(i), i) = 1;
end

disp('LAM training results (T ~= A):');
disp(sum(sum(T ~= A_LAM)));

%% Verifying the Perceptron training
A_Perc = sim(W_Perc, P_train);
[~, class_Perc] = max(A_Perc);

A_LAM = zeros(size(A_Perc));
for i = 1 : N_DIGITS * TRAINING_SAMPLES_PER_DIGIT
    A_Perc(class_Perc(i), i) = 1;
end

disp('Perceptron training results (T ~= A):');
disp(sum(sum(T ~= A_Perc)));
