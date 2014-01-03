%����������������������������������������������������������������������� 
% TP3:  Sistemas Difusos
%  JH:  Dezembro 2013
%����������������������������������������������������������������������� 
clear
close all

SCALE_FACTOR = 0.02;
CONTROLLER = 'best_controller';

%��������������������������������������������������������������������  1
%������������������������������������������������ Defini�o da referencia
load R.dat        %.. Vector  de dimens�o (1,N)
N = length(R);    %.. Numero de instantes


%=======================================================================
%::::::      Trabalho a realizar pelos alunos !!!!!!  
%=======================================================================
%  Implementacao do controlador difuso
%     - Deve guardar o valor da acao de controlo:   U (1, N) 
%     - Deve guardar o valor da saida:              Y (1, N) 
%=======================================================================

if size(R,2) > size(R,1)
    R = R';
end

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

%��������������������������������������������������������������������  3
%����������������������������������������������    Criterio de avaliacao
clc
E     = R-Y;
dU    = diff(U);
ERRO  = (1/N)*(  sum(E.^2) + sum(dU.^2)  );
stERRO= [ 'Criterio Erro: ' num2str(ERRO) ];


%���������������������������������������������� Visualizacao do resultado
figure(1)
plot(1:N,R,'g',1:N,Y,'r',1:N,U,'b')
legend('Referencia','Saida','Controlo')
xlabel(stERRO,'Color','r','FontSize',20)

