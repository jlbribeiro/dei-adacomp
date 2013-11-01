%% Constants
DIGITS = '0123456789pme';
N_DIGITS = length(DIGITS);

SAMPLES_PER_DIGIT = 10;

%% Initializing digit size struct
digit_size = struct();
digit_size.width = 5;
digit_size.height = 5;

%% Load digits datasets into the full dataset matrix
P_dataset = zeros(digit_size.width * digit_size.height, N_DIGITS * SAMPLES_PER_DIGIT);
for i = 1 : N_DIGITS;
   P_dataset(:, (i - 1) * SAMPLES_PER_DIGIT + 1 : i * SAMPLES_PER_DIGIT) = load(sprintf('../dataset/P_%s.dat', DIGITS(i)));
end;

save('P_dataset.dat', 'P_dataset', '-ascii');