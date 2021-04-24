% A receiver, which converts a modulated signal into a demodulated signal
% y_hat - a vector of L real values, representing the received modulated signal 
% t - a vector of L regularly-spaced time instants
% x_hat - a vector of L real values, representing the demodulated signal
% x_hat_title - a string which describes the operation of the receiver
function [x_hat, x_hat_title] = receiver(y_hat, t)

x_hat_title = 'DSBSC, 5 Hz LPF, BPSK, PCM, 4 uniform quantisation levels, 1.1 Hz LPF';

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


% DSBSC demodulate the received signal from the 10 Hz carrier
y_hat = 2*y_hat.*cos(2*pi*10*t);

% Take 301 samples of the 100 s signal, giving a sample rate of 3 Hz
f_s = 2;
samples = sample(y_hat,f_s*t(end)+1);

% Perform quantisation
symbols = quantise(samples, quantisation_levels);

% Determine the number of bits per symbol
k = ceil(log2(length(quantisation_levels)));

% Perform pulse coded modulation
bits = pcm_encode(symbols, k);

% Determine the number of bits per symbol
k = ceil(log2(length(quantisation_levels)));

% Perform pulse coded demodulation
recovered_symbols = pcm_decode(bits,k);

% Perform dequantisation
v_quantised = dequantise(recovered_symbols, quantisation_levels);

u = desample(v_quantised, t);

% Low pass filter the samples to reconstruct the signal
x_hat = low_pass_filter(u, t, 2);


