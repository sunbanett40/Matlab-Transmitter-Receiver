% A receiver, which converts a modulated signal into a demodulated signal
% y_hat - a vector of L real values, representing the received modulated signal 
% t - a vector of L regularly-spaced time instants
% x_hat - a vector of L real values, representing the demodulated signal
% x_hat_title - a string which describes the operation of the receiver
function [x_hat, x_hat_title] = receiver(y_hat, t)

x_hat_title = 'DSBSC, 5 Hz LPF, BPSK, PCM, 4 uniform quantisation levels, 1.1 Hz LPF';

% DSBSC demodulate the received signal from the 10 Hz carrier
y_hat = 2*y_hat.*cos(2*pi*10*t);

% Low-pass filter the signal using a cut off frequency of 5 Hz
y_hat = low_pass_filter(y_hat,t,5);

% Take 602 samples of the 100 s signal, giving a sample rate of 6 Hz
I = sample(y_hat,2*(3*t(end)+1));

% BPSK demodulate the bits
bits = I>0;

% PCM decode the symbols using 2 bits per symbol
symbols = pcm_decode(bits,2);

% Dequantise the samples using 4 uniform quantisation levels
samples = dequantise(symbols,[-1.5 -0.5 +0.5 +1.5]);

% Convert from discrete in time to continuous in time
x_hat = desample(samples,t);

% Low-pass the signal using a cut off frequency of 1.1 Hz
x_hat = low_pass_filter(x_hat,t,1.1);

% Normalise the reconstructed signal
x_hat = x_hat/sqrt(mean(x_hat.^2));
