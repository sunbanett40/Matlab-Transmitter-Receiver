% A transmitter, which converts a message signal into a modulated signal 
% x - a vector of L real values, representing the message signal
% t - a vector of L regularly-spaced time instants
% y - a vector of L real values, representing the modulated signal
% y_title - a string which describes the operation of the transmitter 
function [y, y_title] = transmitter(x, t)

% Describe the operation of the transmitter
y_title = '3 Hz sampling, 4 uniform quantisation levels, PCM, BPSK, raised cosine filter, DSBSC';

% Take 301 samples of the 100 s signal, giving a sample rate of 3 Hz
samples = sample(x,4.5*t(end)+1);

% Lloyd-Max quantiser for Gaussian distributed random signals having a mean of zero and a variance of 1
%quantisation_levels = [-0.7979 0.7979]; 
quantisation_levels = [-1.5104 -0.4528 0.4528 1.5104];
%quantisation_levels = [-2.1520 -1.3439 -0.7560 -0.2451 0.2451 0.7560 1.3439 2.1520];
%quantisation_levels = [-2.7326 -2.0690 -1.6181 -1.2562 -0.9423 -0.6568 -0.3880 -0.1284 0.1284 0.3880 0.6568 0.9423 1.2562 1.6181 2.0690 2.7326];

% Quantise the samples using 4 uniform quantisation levels
symbols = quantise(samples,quantisation_levels);

% PCM encode the symbols using 2 bits per symbol
bits = pcm_encode(symbols,2);

% BPSK modulate the bits
I = 2*bits - 1;

% Calculate the symbol rate
number_of_samples = length(I);
f_symbol = (number_of_samples-1)/t(end);

% Convert from discrete in time to continuous in time
y = desample(I, t);

% Use a raised cosine filter for pulse shaping
y = raised_cosine_filter(y,t,f_symbol);

% Normalise and amplify the pulsed-shaped signal
y = 55*y/sqrt(mean(y.^2));
y = low_pass_filter(y,t,5.2);

% DSBSC modulate the pulse-shaped signal onto a 10 Hz carrier
y = y.*cos(2*pi*10*t);






