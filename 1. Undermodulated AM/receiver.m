% A receiver, which converts a modulated signal into a demodulated signal
% y_hat - a vector of L real values, representing the received modulated signal
% t - a vector of L regularly-spaced time instants
% x_hat -  a vector of L real values, representing the demodulated signal
% x_hat_title - a string which describes the operation of the receiver
function [x_hat, x_hat_title] = receiver(y_hat, t)

% Describe the operation of the receiver
x_hat_title = 'Non-coherent demodulator using half-wave rectifiction and a LPF cutoff frequency of 1.5 Hz';

% Half-wave rectify the received signal
x_hat = max(y_hat,0);

% Choose a cutoff frequency
f_cutoff = 1.5;

% Low pass filter the signal
x_hat = low_pass_filter(x_hat,t,f_cutoff);

% Remove the DC offset
x_hat = x_hat-mean(x_hat);

% Normalise the signal
x_hat = x_hat/sqrt(mean(x_hat.^2));
