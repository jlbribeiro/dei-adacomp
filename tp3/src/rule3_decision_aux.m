number_of_graphs = 9;

desired_temperature_25 = 25*ones(1,11);
desired_temperature_15 = 15*ones(1,11);
desired_temperature_5 = 5*ones(1,11);

increasing_temperature = [10 15];
same_temperature = [15 15];
decreasing_temperature = [15 10];

for i=1:number_of_graphs
    subplot(4,3,i);
    
    if mod(i,3)==1
        evolution_temperature = increasing_temperature;
    elseif mod(i,3)==2
        evolution_temperature = same_temperature;
    elseif mod(i,3)==0
        evolution_temperature = decreasing_temperature;
    end
    
    if i<=3
        desired_temperature = desired_temperature_5;
    elseif i<6
        desired_temperature = desired_temperature_15;
    elseif i==6
        desired_temperature = desired_temperature-5;
    elseif i<=9
        desired_temperature = desired_temperature_25;
    end
    
    error = desired_temperature(5)-evolution_temperature(2);
    error_1 = desired_temperature(2)-evolution_temperature(1);
    error_var = error - error_1;
    
    plot([2 5],evolution_temperature,[2 5],evolution_temperature,'kd',0:10,desired_temperature,'r--');    
    xlabel(sprintf('Erro=%d  Var.Erro=%d',error,error_var));
    axis([0 10 0 30]);
    if i==8
        legend('Evolucao da temperatura','Temperatura nos instantes 2 e 5','Temperatura desejada','Location','SouthOutside');
    end
end
