% A transmitter, which converts a message signal into a modulated signal 
% x - a vector of L real values, representing the message signal
% t - a vector of L regularly-spaced time instants
% y - a vector of L real values, representing the modulated signal
% y_title - a string which describes the operation of the transmitter 
function [y, y_title] = transmitter(x, t)

% Describe the operation of the transmitter
y_title = '3 Hz sampling, 4 uniform quantisation levels, PCM, BPSK, raised cosine filter, DSBSC';

% Take 301 samples of the 100 s signal, giving a sample rate of 3 Hz
samples = sample(x,3*t(end)+1);

% Quantise the samples using 4 uniform quantisation levels
symbols = quantise(samples,[-1.5 -0.5 +0.5 +1.5]);

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
y = 10*y/sqrt(mean(y.^2));

% DSBSC modulate the pulse-shaped signal onto a 10 Hz carrier
y = y.*cos(2*pi*10*t);






