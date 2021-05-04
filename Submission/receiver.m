% A receiver, which converts a modulated signal into a demodulated signal
% y_hat - a vector of L real values, representing the received modulated signal
% t - a vector of L regularly-spaced time instants
% x_hat -  a vector of L real values, representing the demodulated signal
% x_hat_title - a string which describes the operation of the receiver
function [x_hat, x_hat_title] = receiver(y_hat, t)

% Carrier frequency
f_c1 = 6.2;
f_c2 = 8.7;
f_c3 = 11.3;
f_c4 = 13.8;

% Perform coherent demodulation
x1_hat1 = y_hat.*cos(2*pi*f_c1*t);
x1_hat2 = y_hat.*sin(2*pi*f_c1*t);

x2_hat1 = y_hat.*cos(2*pi*f_c2*t);
x2_hat2 = y_hat.*sin(2*pi*f_c2*t);

x3_hat1 = y_hat.*cos(2*pi*f_c3*t);
x3_hat2 = y_hat.*sin(2*pi*f_c3*t);

x4_hat1 = y_hat.*cos(2*pi*f_c4*t);
x4_hat2 = y_hat.*sin(2*pi*f_c4*t);

% Choose a cutoff frequency in Hertz
f_cutoff = 1.2;

% Low pass filter the signal
x1_hat1 = low_pass_filter(x1_hat1,t,f_cutoff);
x1_hat1 = low_pass_filter(x1_hat1,t,f_cutoff);
x1_hat2 = low_pass_filter(x1_hat2,t,f_cutoff);
x1_hat2 = low_pass_filter(x1_hat2,t,f_cutoff);

x2_hat1 = low_pass_filter(x2_hat1,t,f_cutoff);
x2_hat1 = low_pass_filter(x2_hat1,t,f_cutoff);
x2_hat2 = low_pass_filter(x2_hat2,t,f_cutoff);
x2_hat2 = low_pass_filter(x2_hat2,t,f_cutoff);

x3_hat1 = low_pass_filter(x3_hat1,t,f_cutoff);
x3_hat1 = low_pass_filter(x3_hat1,t,f_cutoff);
x3_hat2 = low_pass_filter(x3_hat2,t,f_cutoff);
x3_hat2 = low_pass_filter(x3_hat2,t,f_cutoff);

x4_hat1 = low_pass_filter(x4_hat1,t,f_cutoff);
x4_hat1 = low_pass_filter(x4_hat1,t,f_cutoff);
x4_hat2 = low_pass_filter(x4_hat2,t,f_cutoff);
x4_hat2 = low_pass_filter(x4_hat2,t,f_cutoff);

%combine signals
x_hat = x1_hat1 + x1_hat2 + x2_hat1 + x2_hat2 + x3_hat1 + x3_hat2 +x4_hat1 + x4_hat2;

f_cutoff_2 = 1.5;

x_hat = low_pass_filter(x_hat,t,f_cutoff_2);
x_hat = low_pass_filter(x_hat,t,f_cutoff_2 + 0.1);

% Remove the DC offset
x_hat = x_hat-mean(x_hat);

% Normalise the signal
x_hat = x_hat/sqrt(mean(x_hat.^2));

%Describe the operation of the receiver
%https://www.mathworks.com/matlabcentral/answers/323435-how-do-i-put-variable-values-into-a-text-string-for-legend
legend1 = sprintf('JDB1G20 - Coherent demodulator using and a LPFs cutoff frequency of %.1f and %.1f', f_cutoff, f_cutoff_2);
%https://www.mathworks.com/matlabcentral/answers/26174-break-title-into-multiple-lines
x_hat_title = {legend1};