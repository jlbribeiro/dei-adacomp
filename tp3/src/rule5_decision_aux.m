number_of_graphs = 25;

desired_temperature_25 = 25*ones(1,11);
desired_temperature_20 = 20*ones(1,11);
desired_temperature_15 = 15*ones(1,11);
desired_temperature_10 = 10*ones(1,11);
desired_temperature_5 = 5*ones(1,11);

increasing_temperature = [10 15];
increasing_slight_temperature = [12 14];
same_temperature = [15 15];
decreasing_slight_temperature = [14 12];
decreasing_temperature = [15 10];

for i=1:number_of_graphs
    subplot(6,5,i);
    
    if mod(i,5)==1
        evolution_temperature = increasing_temperature;
    elseif mod(i,5)==2
        evolution_temperature = increasing_slight_temperature;
    elseif mod(i,5)==3
        evolution_temperature = same_temperature;
    elseif mod(i,5)==4
        evolution_temperature = decreasing_slight_temperature;
    elseif mod(i,5)==0
        evolution_temperature = decreasing_temperature;
    end
    
    if i<=5
        desired_temperature = desired_temperature_5;
    elseif i<=10
        desired_temperature = desired_temperature_10;
    elseif i==11
        desired_temperature = desired_temperature_15;    
    elseif i==12
        desired_temperature = desired_temperature_15-1;
    elseif i==13
        desired_temperature = desired_temperature_15;  
    elseif i==14
        desired_temperature = desired_temperature_15-3;
    elseif i==15
        desired_temperature = desired_temperature_15-5;
    elseif i<=20
        desired_temperature = desired_temperature_20;
    elseif i<=25
        desired_temperature = desired_temperature_25;
    end
    
    error = desired_temperature(5)-evolution_temperature(2);
    error_1 = desired_temperature(2)-evolution_temperature(1);
    error_var = error - error_1;
    
    plot([2 5],evolution_temperature,[2 5],evolution_temperature,'kd',0:10,desired_temperature,'r--');    
    xlabel(sprintf('Erro=%d  Var.Erro=%d',error,error_var));
    axis([0 10 0 30]);
    if i==8
        %legend('Evolucao da temperatura','Temperatura nos instantes 2 e 5','Temperatura desejada','Location','SouthOutside');
    end
end
