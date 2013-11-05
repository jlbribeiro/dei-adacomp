%% "Importing" constants and structs
constants_structs

%% Load data to be recognized
load P.dat;

%% Load Perceptron Weights
load W_Perc;
load W_LAM;

%% Recognize each digit on the network
expression = zeros(1, size(P, 2));
for i = 1 : size(P, 2);
    P_i = P(:, i);

    fprintf('\n');
    disp(char(digit_column_to_matrix(DIGIT_SIZE, P_i) * ('0' - '.') + '.'));
    fprintf('\n');

    A_LAM = W_LAM * P_i;
    % A_Perc = sim(W_Perc, P_i);

    [~, digit_i] = max(A_LAM);
    % [~, digit_i] = max(A_Perc);
    
    expression(i) = DIGITS(digit_i);

    fprintf('Recognized symbol:\t%s\n', expression(i));
end;

expression = char(expression);
last_char_equal = (expression(end) == '=');

fprintf('\nExpression: %s ', expression);

%% Evaluate the expression's result
result = eval(expression(1 : end - last_char_equal)); % ignore the equal sign if present

if ~last_char_equal
    fprintf('= ');
end;

fprintf('%d\n', result);