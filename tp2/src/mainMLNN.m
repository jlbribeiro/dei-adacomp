%�������������������������������������������������������������������������
% JH - Novembro 2013
% Exemplo completo para treino de uma rede
% Nao se aceitam reclamacoes   :)
%�������������������������������������������������������������������������

clc
clear
pack
close all

%:::: Dados para treino
%-------------------------------------------------------------------
load('../dataset/dataset1')
P=X1';
T=T1';
N=1000;  % considerar 1000 exemplos de treino
P=P(:,1:N);
T=T(:,1:N);


%:::: Parametros
%-------------------------------------------------------------------
nh          = 20;        %...   Numero de neuronios camada escondida EXPERIMENTAR
coefAprend  = 0.0001;    %...   Coeficiente de aprendiagem EXPERIMENTAR
epocas      = 200;       %...   Numero de epocas EXPERIMENTAR
treino      ='trainlm';
normalizar  =1;
   
%Normalizacao [0..1]
if normalizar
   for i=1:size(P,1)
       P(i,:)=P(i,:)/max(P(i,:));
   end
end

model = pca(P);
model.eingval

%__________________________________________________________________________
% 1. DEFINICAO DA REDE  :::::::::::::::::::::::::::::::::::::::::::::::::::
%�����������������������������������������������������
disp('--------------------------------------- Definition of FF-------------')

%::::::::::::::::: numero de entradas e de saidas
[np,nQ] =size(P);
[nt,nQ] =size(T);

%::::::::::::::::: Pesos e desvios iniciais
W1= 0.01*rand(nh,np);
W2= 0.01*rand(nt,nh);
B1= 0.2*rand(nh,1);

%::::::::::::::::: Inicializacao
net = newff( P, T, [nh nt] ,{'tansig','purelin'}, treino );

%::::::::::::::::: Parametros
net.trainParam.epochs = epocas;
net.trainParam.show = 50;
net.trainParam.goal = 1e-4;
net.trainParam.lr = coefAprend;
net.performFcn = 'sse';
net.trainParam.mu_max = 1e1 ;

%::::::::::::::::: Inicializacao
net.IW{1,1}=W1;
net.LW{2,1}=W2;
net.b{1,1}= B1;

%__________________________________________________________________________
% 2. TREINO DA REDE   :::::::::::::::::::::::::::::::::::::::::::::::::::::
%�����������������������������������������������������
disp('------------------------------------------ Training -------------')
[net] = train(net,P,T);

%:::::::::::::::::  Pesos finais (nao interessam para nada!)
W1=net.IW{1,1};
W2=net.LW{2,1};
B1=net.b{1,1};

disp('---------------------------------------- Verificacao -------------')
Y1  = sim(net,P);
Y1  = round(Y1);
%__________________________________________________________________________
% 3. RESULTADOS   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%�����������������������������������������������������

plot(1:nQ,T-round(Y1),'ro','LineWidth',3)
title(' Target Output / Neural Output ','FontSize',20)
legend('Desejada','Rede','Sim') 

clc
numErrados   = sum(abs((T-round(Y1))))
numCertos    = length(P)-numErrados
percentagem  = numErrados/(numErrados+numCertos)


%__________________________________________________________________________
% 4. CONCURSO   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%�����������������������������������������������������
load dataset2
for i=1:size(X2,1)
     X2(i,:)=X2(i,:)/max(X2(i,:));
end
Y2=sim(net,X2');  
Y2=round(Y2);           % deve ser enviado apenas T2 : vector de {0,1]



