function performance_plot( percCorrect, sensibility, specificity )
    %% Calculating remaining values
    percIncorrect = 1 - percCorrect;

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

