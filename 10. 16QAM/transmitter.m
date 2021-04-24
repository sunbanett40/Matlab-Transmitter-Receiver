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

% Choose quantisation levels

% Uniform quantiser for signals in the range -1 to 1
%quantisation_levels = [-0.5 0.5];
%quantisation_levels = [-0.75 -0.25 0.25 0.75];
%quantisation_levels = [-0.875 -0.625 -0.375 -0.125 0.125 0.375 0.625 0.875];

% Uniform quantiser for Gaussian distributed random signals having a mean of zero and a variance of 1
%quantisation_levels = [-1 1];
%quantisation_levels = [-1.5 -0.5 0.5 1.5];
%quantisation_levels = [-1.75 -1.25 -0.75 -0.25 0.25 0.75 1.25 1.75];

% Lloyd-Max quantiser for sinusoidal signals having an amplitude of A=1
%quantisation_levels = [-0.6366 0.6366]; 
%quantisation_levels = [-0.8541 -0.2972 0.2972 0.8541]; 
%quantisation_levels = [-0.9388 -0.6985 -0.4279 -0.1440 0.1440 0.4279 0.6985 0.9388];

% Lloyd-Max quantiser for Gaussian distributed random signals having a mean of zero and a variance of 1
%quantisation_levels = [-0.7979 0.7979]; 
%quantisation_levels = [-1.5104 -0.4528 0.4528 1.5104];
%quantisation_levels = [-2.1520 -1.3439 -0.7560 -0.2451 0.2451 0.7560 1.3439 2.1520];
quantisation_levels = [-2.7326 -2.0690 -1.6181 -1.2562 -0.9423 -0.6568 -0.3880 -0.1284 0.1284 0.3880 0.6568 0.9423 1.2562 1.6181 2.0690 2.7326];

% Quantise the samples using 4 uniform quantisation levels
symbols = quantise(samples,quantisation_levels);

M=16;
I = qammod(symbols ,M,'PlotConstellation',true);

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
k_am = 1.3;
y1 = k_am*y.*cos(2*pi*6.8*t);
y2 = k_am*y.*cos(2*pi*13.2*t);
y = y1+y2;





