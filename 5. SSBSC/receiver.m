% A receiver, which converts a modulated signal into a demodulated signal
% y_hat - a vector of L real values, representing the received modulated signal
% t - a vector of L regularly-spaced time instants
% x_hat -  a vector of L real values, representing the demodulated signal
% x_hat_title - a string which describes the operation of the receiver
function [x_hat, x_hat_title] = receiver(y_hat, t)

f_c = 13.9;

% Perform coherent demodulation
x_hat = y_hat.*cos(2*pi*f_c*t);

% Choose a cutoff frequency in Hertz
f_cutoff = 1;

% Low pass filter the signal
x_hat = low_pass_filter(x_hat,t,f_cutoff);

% Remove the DC offset
x_hat = x_hat-mean(x_hat);

% Normalise the signal
x_hat = x_hat/sqrt(mean(x_hat.^2));

%Describe the operation of the receiver
%https://www.mathworks.com/matlabcentral/answers/323435-how-do-i-put-variable-values-into-a-text-string-for-legend
legend1 = sprintf('Non-coherent demodulator using half-wave rectifiction and a LPF cutoff frequency of %f', f_cutoff);
%https://www.mathworks.com/matlabcentral/answers/26174-break-title-into-multiple-lines
x_hat_title = {legend1};