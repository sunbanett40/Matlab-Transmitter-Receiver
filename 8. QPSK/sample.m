% Sample a signal, in order to obtain some samples
% signal - a vector of L real values
% number_of_samples - the number K of samples to select from signal
% samples - a vector of K real values, selected from signal
function samples = sample(signal, number_of_samples)

% Choose the K real values in signal to retain
sample_indices = round((0:number_of_samples-1)*(length(signal)-1)/(number_of_samples-1))+1;

% Copy these K real values into samples
samples = signal(sample_indices);

