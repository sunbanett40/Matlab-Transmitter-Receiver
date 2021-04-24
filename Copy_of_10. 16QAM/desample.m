% Desample some samples, in order to obtain a signal
% samples - a vector of K real values
% t - a vector of L regularly-spaced time instants
% signal - a vector of L real values, K of which will be regularly-spaced
%    replicas of the values in samples, the rest of which will have the 
%    value zero
function signal = desample(samples, t)

% Choose the K elements of signal to populate with the values from samples
sample_indices = round((0:length(samples)-1)*(length(t)-1)/(length(samples)-1))+1;

% Set most values in signal to zero
signal = zeros(size(t));

% Populate the K elements of signal with the values from samples
signal(sample_indices) = samples;
