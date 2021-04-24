% A transmitter, which converts a message signal into a modulated signal
% x -  a vector of L real values, representing the message signal
% t - a vector of L regularly-spaced time instants
% y - a vector of L real values, representing the modulated signal
% y_title - a string which describes the operation of the transmitter
function [y, y_title] = transmitter(x, t)

% Describe the operation of the transmitter
y_title = 'Undermodulated AM using f_c = 10, V_c = 2.5 and k_{am} = 1';

% Carrier frequency
f_c = 10;

% DC offset
V_c = 2.5;

% Modulation sensitivity
k_am = 1;

% Full AM modulation
y = (V_c+k_am*x).*cos(2*pi*f_c*t);
