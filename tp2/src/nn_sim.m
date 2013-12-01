function [ Y ] = nn_sim( varargin )
%% nn_sim(net, P [, T])

    net = varargin{1};
    P = varargin{2};

    if nargin == 3
        T = varargin{3};
    end

    %% Constants
    constants;

    %% Verify NN's output
    Y = sim(net, P);
    Y = round(Y);

    if nargin == 3
        %% Percentage of (in)correct classifications
        nIncorrect = sum(abs(T - Y));
        nCorrect   = length(P) - nIncorrect;

        percCorrect  = nCorrect / (nIncorrect + nCorrect);
        percIncorrect = nIncorrect / (nIncorrect + nCorrect);

        %% Sensibility and specificity
        conf_matrix = confusionmat(Y, T);
        sensibility = conf_matrix(2, 2) / (conf_matrix(2, 2) + conf_matrix(2, 1));
        specificity = conf_matrix(1, 1) / (conf_matrix(1, 1) + conf_matrix(1, 2));

        %% Performance charts (Correct pattern classifications, Incorrect pattern classifications, Sensibility, Specificity)
        y_Values = [percCorrect, percIncorrect] * 100;
        x_Values = [-1 1];
        y_Values2 = [sensibility, specificity] * 100;
        x_Values2 = [3 5];

        bar(x_Values, y_Values, 'b');
        hold on
        bar(x_Values2, y_Values2, 'g');
        hold off
        axis([-3 7 0 100]);

        set(gca, 'XTick', [-1, 1, 3, 5], 'XTickLabel', [{'Correct pattern classifications'}, {'Incorrect pattern classifications'}, {'Sensibility'}, {'Specificity'}]);
        title('Performance analysis of FF Neural Network');

        xlabel('Type of classifications');
        ylabel('Percentage');
    end
end