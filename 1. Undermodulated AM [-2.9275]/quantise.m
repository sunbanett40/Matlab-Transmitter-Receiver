% Quantise some samples, in order to obtain the corresponding symbols
% samples - a vector of N real values
% quantisation_levels - a vector of M real values
% symbols - a vector of N integers in the range 0 to M-1
function symbols = quantise(samples, quantisation_levels)

% Obtain matrices so that we can compare each sample with each quantisation
% level
[samples_mat, quantisation_levels_mat] = meshgrid(samples,quantisation_levels);

% Calculate the error offered by using each quantisation level to represent
% each sample
errors = abs(samples_mat-quantisation_levels_mat);

% Choose the best quantisation level for each sample
[~,symbols] = min(errors);

% Convert from the range 1 to M, into the range 0 to M-1
symbols = symbols - 1;