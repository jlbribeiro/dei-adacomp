warning('off','MATLAB:DELETE:FileNotFound');

%% Delete datasets
delete('P.dat', 'P_dataset.dat', 'P_train.dat', 'P_valid.dat');

%% Delete Neural-Network Weights
delete('W_LAM.mat', 'W_Perc.mat');

warning('on','MATLAB:DELETE:FileNotFound');