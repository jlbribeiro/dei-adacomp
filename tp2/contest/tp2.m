%% Constants
N_FEATURES = 6;

%% Contest data validation
load('dataset2'); %% loads X2

%% Contest data should be normalized
[~, n_features] = size(X2);
X2_ = zeros(size(X2));
for i = 1 : n_features
    mu = mean(X2(:, i));
    sig = std(X2(:, i));
    X2_(:, i) = (X2(:, i) - mu) / sig;
end

X2 = X2_;

[~, scores, ~] = princomp(X2);
X2 = scores(:, 1 : N_FEATURES);

X2 = X2';

%% Load NN
load('best_net');

Y2 = sim(best_net, X2);
Y2 = round(Y2);

Y2 = Y2';

save('Y2.dat', 'Y2');