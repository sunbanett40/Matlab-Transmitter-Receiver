% A transmitter, which converts a message signal into a modulated signal
% x -  a vector of L real values, representing the message signal
% t - a vector of L regularly-spaced time instants
% y - a vector of L real values, representing the modulated signal
% y_title - a string which describes the operation of the transmitter
function [y, y_title] = transmitter(x, t)

V_c = -3.5;

% Carrier frequency
f_c1 = 6.2;
f_c2 = 8.7;
f_c3 = 11.3;
f_c4 = 13.8;

% Modulation sensitivity
k_am = 24.4;

% Full AM modulation
y1 = (V_c+k_am*x).*cos(2*pi*f_c1*t)+(V_c+k_am*x).*sin(2*pi*f_c1*t);
y2 = (V_c+k_am*x).*cos(2*pi*f_c2*t)+(V_c+k_am*x).*sin(2*pi*f_c2*t);
y3 = (V_c+k_am*x).*cos(2*pi*f_c3*t)+(V_c+k_am*x).*sin(2*pi*f_c3*t);
y4 = (V_c+k_am*x).*cos(2*pi*f_c4*t)+(V_c+k_am*x).*sin(2*pi*f_c4*t);

y = (y1+y2+y3+y4);

% Calculate Modulation index
m_mod = k_am*max(x(1:1000))/V_c*100;

% Describe the operation of the transmitter
%https://www.mathworks.com/matlabcentral/answers/323435-how-do-i-put-variable-values-into-a-text-string-for-legend
legend1 = sprintf('using f_c = %.1f, %.1f, %.1f, %.1f k_{am} = %.1f, V_c =%1.0f, and k_{am} = %.1f', f_c1, f_c2, f_c3, f_c4, V_c, k_am);
%https://www.mathworks.com/matlabcentral/answers/26174-break-title-into-multiple-lines
y_title = {'JDB1G20 - 4 QAM Signals' legend1};
