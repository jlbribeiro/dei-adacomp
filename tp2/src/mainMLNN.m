
clc
clear
pack
close all

%:::: Dados para treino
%-------------------------------------------------------------------
load('../dataset/training_dataset')
load('../dataset/validation_dataset')
P_train=X1_train';
T_train=T1_train';
P_validation=X1_validation';
T_validation=T1_validation';


%:::: Parametros
%-------------------------------------------------------------------
nh          = 15;        %.   Numero de neuronios camada escondida EXPERIMENTAR
coefAprend  = 0.001;    %...   Coeficiente de aprendiagem EXPERIMENTAR
epocas      = 100;       %...   Numero de epocas EXPERIMENTAR
treino      ='trainlm';
   
%Normalizacao [0..1]
%if normalizar
%   for i=1:size(P,1)
%       P(i,:)=P(i,:)/max(P(i,:));
%   end
%end

%model = pca(P);
%model.eigval

%__________________________________________________________________________
% 1. DEFINICAO DA REDE  :::::::::::::::::::::::::::::::::::::::::::::::::::
%�����������������������������������������������������
disp('--------------------------------------- Definition of FF-------------')

%::::::::::::::::: numero de entradas e de saidas
[np,nQ] =size(P_train);
[nt,nQ] =size(T_train);

%::::::::::::::::: Pesos e desvios iniciais
W1= 0.01*rand(nh,np);
W2= 0.01*rand(nt,nh);
B1= 0.2*rand(nh,1);

%::::::::::::::::: Inicializacao
net = newff( P_train, T_train, [nh] ,{'tansig'}, treino );

%::::::::::::::::: Parametros
net.trainParam.epochs = epocas;
net.trainParam.show = 50;
net.trainParam.goal = 1e-6;
net.trainParam.lr = coefAprend;
net.performFcn = 'sse';
% net.trainParam.mu_max = 1e1 ;

%::::::::::::::::: Inicializacao
net.IW{1,1}=W1;
net.LW{2,1}=W2;
net.b{1,1}= B1;
net.divideFcn=''

%__________________________________________________________________________
% 2. TREINO DA REDE   :::::::::::::::::::::::::::::::::::::::::::::::::::::
%�����������������������������������������������������
disp('------------------------------------------ Training -------------')
[net] = train(net,P_train,T_train);

%:::::::::::::::::  Pesos finais (nao interessam para nada!)
W1=net.IW{1,1};
W2=net.LW{2,1};
B1=net.b{1,1};

disp('---------------------------------------- Verificacao -------------')
Y1  = sim(net,P_validation);
Y1  = round(Y1);
%__________________________________________________________________________
% 3. RESULTADOS   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%�����������������������������������������������������

%plot(1:length(T_validation),T_validation-round(Y1),'ro','LineWidth',3)
%title(' Target Output / Neural Output ','FontSize',20)
%legend('Desejada','Rede','Sim') 


% 
numErrados   = sum(abs((T_validation-round(Y1))))
numCertos    = length(P_validation)-numErrados
percentagemCertos  = numCertos/(numErrados+numCertos) %Calcular a percentagem de exemplos correctos
percentagemErrados  = numErrados/(numErrados+numCertos) %Calcular a percentagem de exemplos correctos

% Sensibility and specificity
conf_matrix = confusionmat(Y1,T_validation);
sensibility = conf_matrix(2,2)/(conf_matrix(2,2)+conf_matrix(2,1))
specificity = conf_matrix(1,1)/(conf_matrix(1,1)+conf_matrix(1,2))


y_Values = [percentagemCertos, percentagemErrados]*100;
x_Values = [-1 1];
y_Values2 = [sensibility, specificity]*100;
x_Values2 = [3 5];


bar(x_Values, y_Values,'b');
hold on
bar(x_Values2, y_Values2,'g');
hold off
axis([-3 7 0 100]);

set(gca,'XTick',[-1,1,3,5],'XTickLabel',[{'Well classified Examples'},{'Examples wrongly classified'},{'Sensibility'},{'Specificity'}]);
% set(gca, 'XTickLabel', {'Well classified Examples', '', 'Sensibility', 'Specificity'});
title('Performance analysis of FF Neural Network');
 
xlabel('Type of classifications');
ylabel('Percentage');


%__________________________________________________________________________
% 4. CONCURSO   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%�����������������������������������������������������

%load('../dataset/test_dataset')
%for i=1:size(X2,1)
%     X2(i,:)=X2(i,:)/max(X2(i,:));
%end
%Y2=sim(net,X2');  
%Y2=round(Y2);           % deve ser enviado apenas T2 : vector de {0,1]



