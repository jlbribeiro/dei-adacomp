%% Importing constants
constants;

errors = zeros(1,N_RUNS);

for runs=1:N_RUNS

    %% Setting up variables to use in the recurrence equation
    yk = 0;
    yk_1 = 0;   % Save yk in the previous time slot
    yk_2 = 0;   % Save yk two time slots behind

    uk = 0;     % Power induced
    uk_1 = 0;   % Save uk in the previous time slot
    uk_2 = 0;   % Save uk two time slots behind

    ek = 0;
    ek_1 = 0;

    Y = zeros(N,1);         % Output   (Temperature)
    U = zeros(N,1);         % Input (Power)

    %---------------------------- Controlador
    controller = readfis(CONTROLLER);
    
    if runs == 1
        disp(controller.name);
    end

    for k=1:N

        % System's output: Temperature between 0 and 50
        yk = pt326(uk_1,uk_2,yk_1,yk_2);

        % Calculate reference and errors to use in the fuzzy system as an
        % input
        rk = R(k);
        ek = rk - yk;
        delta_ek = ek - ek_1;
        %Controlling the power's system (Power)
        %uk = uk_1 + GAIN*ek ; % Approach 1
        %uk = rk;  %malha aberta, i.e, controlo=referencia % Approach 2
        delta_uk = evalfis(SCALE_FACTOR*[ek delta_ek],controller); % Approach 3 (Fuzzy system)
        uk = uk_1 + delta_uk * 100;
        if DEBUG
            fprintf('k: %d\n', k);
            fprintf('rk:       %.15f\n', SCALE_FACTOR * rk);
            fprintf('yk:       %.15f\n', SCALE_FACTOR * yk);
            fprintf('ek:       %.15f\n', SCALE_FACTOR * ek);
            fprintf('delta_ek: %.15f\n', SCALE_FACTOR * delta_ek);
            fprintf('uk:       %.15f\n', uk);
            fprintf('delta_uk: %.15f\n', delta_uk);
            fprintf('\n');
        end
            
        % Power should be a value between 0 and 100
        if uk < 0
            uk = 0;
        elseif uk > 100
            uk = 100;
        end

        %Calculate output values to use as entries for the next step
        Y(k) = yk;
        U(k) = uk;

        ek_1 = ek;

        uk_2 = uk_1;
        uk_1 = uk;

        yk_2 = yk_1;
        yk_1 = yk;
    end

    %% Evaluating performance
    errors(runs) = (quadratic_error(R,Y) + quadratic_error(U))/N;

    %% Plot Data Results
    if DEBUG
        figure;
        plot(t,R,'g',t,Y,'r',t,U,'b','LineWidth',2);
%         legend('Ref','Out','Inp')
        pause
    end
    
    fprintf('--> END OF RUN #%d: Error = %.3f\n', runs, errors(runs));
end

mean_error = mean(errors);
stddev_error = std(errors);

fprintf('\n\n\n---       END OF SIMULATION       ---\n');
fprintf('Global Results:\n');
fprintf('Error mean: %.3f\n',mean_error);
fprintf('Error standard deviation: %.3f\n',stddev_error);
