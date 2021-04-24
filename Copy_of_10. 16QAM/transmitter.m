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

quantisation_levels = [-2.7326 -2.0690 -1.6181 -1.2562 -0.9423 -0.6568 -0.3880 -0.1284 0.1284 0.3880 0.6568 0.9423 1.2562 1.6181 2.0690 2.7326];

% Perform quantisation
symbols = quantise(samples, quantisation_levels);

% Determine the number of bits per symbol
k = ceil(log2(length(quantisation_levels)));

% Perform pulse coded modulation
bits = pcm_encode(symbols, k);

% 16-QAM    M=16 k=4       I = (2*b1-1)*(3-2*b2)   Q = -(2*b3-1)*(3-2*b4)
%
%                        I      Q             b1  b2  b3  b4    
constellation_points = [-3      3;... %       0   0   0   0
                        -1      3;... %       0   0   0   1
                         3      3;... %       0   0   1   0
                         1      3;... %       0   0   1   1
                        -3     -3;... %       0   1   0   0
                        -1     -3;... %       0   1   0   1
                         3     -3;... %       0   1   1   0
                         1     -3;... %       0   1   1   1
                        -3      1;... %       1   0   0   0
                        -1      1;... %       1   0   0   1
                         3      1;... %       1   0   1   0
                         1      1;... %       1   0   1   1
                        -3     -1;... %       1   1   0   0
                        -1     -1;... %       1   1   0   1
                         3     -1;... %       1   1   1   0
                         1     -1];   %       1   1   1   1
         
% Determine M-ary
M = size(constellation_points, 1);

% Choose bits per modulation symbol
k2 = log2(M);

% Perform pulse coded modulation
symbols2 = pcm_decode(bits, k2);

% Convert from discrete in time to continuous in time
u = desample(symbols2, t);

% Determine modulation symbol rate
f_m = 3*k/k2;

% Use a raised cosine filter for pulse shaping
u = raised_cosine_filter(u,t,f_m);

% Normalise and amplify the pulsed-shaped signal
%u = 10*u/sqrt(mean(u.^2));

% Determine in-phase message signal
v_mi = constellation_points(u+1,1);

% Determine quadrature-phase message signal
v_mq = constellation_points(u+1,2);


% Choose carrier frequency
f_c = 10;

% Perform PSK modulation
y = v_mi'.*cos(2*pi*f_c*t_new) - v_mq'.*sin(2*pi*f_c*t_new);







