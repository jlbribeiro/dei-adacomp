function [net] = nn_train( P, T )
    %% Constants
    constants;

    %% Setting number of inputs and outputs (P and T)
    [np, ~] = size(P);
    [nt, ~] = size(T);

    %% Initial weights and bias
    IW = 0.01 * rand(N_HIDDEN_NEURONS, np);
    LW = 0.01 * rand(nt, N_HIDDEN_NEURONS);
    B = 0.2 * rand(N_HIDDEN_NEURONS, 1);

    %% Create Feed-Forward NN
    net = newff(P, T, [N_HIDDEN_NEURONS], {'tansig'}, TRAINING_METHOD);

    %% Setting parameters
    net.trainParam.epochs = N_EPOCHS;
    net.trainParam.show = 50;
    net.trainParam.goal = 1e-6;
    net.trainParam.lr = LEARNING_RATE;
    net.performFcn = 'sse';
    % net.trainParam.mu_max = 1e1;
    net.trainParam.showWindow = DEBUG;

    %% Setting the initial weights (created above)
    net.IW{1, 1} = IW;
    net.LW{2, 1} = LW;
    net.b{1, 1} = B;
    net.divideFcn = '';

    %% Neural-Network training
    net = train(net, P, T);
end
