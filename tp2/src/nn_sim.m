function [ Y, percCorrect, sensibility, specificity ] = nn_sim( varargin )
%% nn_sim(net, P [, T])

    net = varargin{1};
    P = varargin{2};

    if nargin == 3
        T = varargin{3};
    end

    %% Verify NN's output
    Y = sim(net, P);
    Y = round(Y);

    if nargin == 3
        %% Percentage of (in)correct classifications
        n_patterns = length(P);
        nCorrect = n_patterns - sum(abs(T - Y));
        percCorrect  = nCorrect / n_patterns;

        %% Sensibility and specificity
        conf_matrix = confusionmat(Y, T);
        sensibility = conf_matrix(2, 2) / (conf_matrix(2, 2) + conf_matrix(2, 1));
        specificity = conf_matrix(1, 1) / (conf_matrix(1, 1) + conf_matrix(1, 2));
    end
end