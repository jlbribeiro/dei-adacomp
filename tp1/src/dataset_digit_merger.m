%% "Importing" constants and structs
constants_structs

%% Load digits datasets into the full dataset matrix
P_dataset = zeros(DIGIT_SIZE.width * DIGIT_SIZE.height, N_DIGITS * SAMPLES_PER_DIGIT);
for i = 1 : N_DIGITS;
   P_dataset(:, (i - 1) * SAMPLES_PER_DIGIT + 1 : i * SAMPLES_PER_DIGIT) = load(sprintf('../dataset/P_%s.dat', DIGITS_T(i)));
end;

save('P_dataset.dat', 'P_dataset', '-ascii');