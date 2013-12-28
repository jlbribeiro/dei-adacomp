%% Constants
T = 0.1;    % Sampling Rate
D = 100;    % 10 seconds for each "state"
R = [30*ones(D,1); 15*ones(D,1)];   % Reference = Desired temperature
N = length(R);      % Number of samples							   
t = 0:T:(N*0.1-T);  % timeslots
GAIN = 0.07;        % System gain (to multiply with the variation)
SCALE_FACTOR = 0.02;
N_RUNS = 1;
DEBUG = true;