% Dequantise some symbols, in order to obtain the corresponding samples
% symbols - a vector of N integers in the range 0 to M-1
% quantisation_levels - a vector of M real values
% samples - a vector of N real values, selected from quantisation_levels
function samples = dequantise(symbols, quantisation_levels)

% Perform the dequantisation
samples = quantisation_levels(symbols+1);