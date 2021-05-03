% A transmitter, which converts a message signal into a modulated signal
% x -  a vector of L real values, representing the message signal
% t - a vector of L regularly-spaced time instants
% y - a vector of L real values, representing the modulated signal
% y_title - a string which describes the operation of the transmitter
function [y, y_title] = transmitter(x, t)

V_c = 2;

% Carrier frequency
f_c = 13.9;

% Modulation sensitivity
k_am = 34;

% Full AM modulation
y = (V_c+k_am*x).*cos(2*pi*f_c*t);

% Calculate Modulation index
m_mod = k_am*max(x(1:100))/V_c*100;

% Describe the operation of the transmitter
%https://www.mathworks.com/matlabcentral/answers/323435-how-do-i-put-variable-values-into-a-text-string-for-legend
legend1 = sprintf('using f_c = %.1f, k_{am} = %.1f, V_c =%1.0f, and m_{mod} = %3.0f', f_c, V_c, k_am);
%https://www.mathworks.com/matlabcentral/answers/26174-break-title-into-multiple-lines
y_title = {'Double Sideband Suppressed Carrier' legend1};
