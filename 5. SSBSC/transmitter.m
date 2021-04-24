% A transmitter, which converts a message signal into a modulated signal
% x -  a vector of L real values, representing the message signal
% t - a vector of L regularly-spaced time instants
% y - a vector of L real values, representing the modulated signal
% y_title - a string which describes the operation of the transmitter
function [y, y_title] = transmitter(x, t)

V_c = 2;

% Carrier frequency
f_c1 = 500;
f_c2 = f_c1 + 13.9;

% Modulation sensitivity
k_am1 = 16.4;
k_am2 = 2.1;

% Full AM modulation
x = (V_c+k_am1*x).*cos(2*pi*f_c1*t);

% Full AM modulation
y = (V_c+k_am2*x).*cos(2*pi*f_c2*t);

% Low pass filter the signal
y = low_pass_filter(y,t,20);

% Calculate Modulation index
m_mod = k_am1*k_am2*max(x(1:100))/V_c*100;

% Describe the operation of the transmitter
%https://www.mathworks.com/matlabcentral/answers/323435-how-do-i-put-variable-values-into-a-text-string-for-legend
legend1 = sprintf('using f_c = %.1f, k_{am} = %.1f and m_{mod} = %3.0f', f_c2, k_am1*k_am2, m_mod);
%https://www.mathworks.com/matlabcentral/answers/26174-break-title-into-multiple-lines
y_title = {'Double Sideband Suppressed Carrier', legend1};
