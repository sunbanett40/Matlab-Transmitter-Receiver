% Script that quantises a sampled signal
randn('seed',2)

% Choose the time instants in seconds that we want to plot 
t = 0:0.001:1;

% Choose a maximum frequency for our signal in Hertz
f_max = 5;

% Use a sinusoidal signal
%A = 1; % Amplitude
%phi = 0; % Phase in the range 0 to 2*pi
%v = A*cos(2*pi*f_max*t + phi);

% Use a random signal
v = func_random_signal(t, f_max);

% Choose a sampling frequency in Hertz
f_s = 10;

% Sample the signal
[t_sampled, v_sampled] = func_sample(t, v, f_s);

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
%quantisation_levels = [-1.8953 -1.0017 -0.3178 0.3178 1.0017 1.8953];
%quantisation_levels = [-2.1520 -1.3439 -0.7560 -0.2451 0.2451 0.7560 1.3439 2.1520];
quantisation_levels = [-2.7326 -2.0690 -1.6181 -1.2562 -0.9423 -0.6568 -0.3880 -0.1284 0.1284 0.3880 0.6568 0.9423 1.2562 1.6181 2.0690 2.7326];

% Perform quantisation
symbols = func_quantise(v_sampled, quantisation_levels)

% Perform dequantisation
v_quantised = func_dequantise(symbols, quantisation_levels);

% Low pass filter the samples to reconstruct the signal
v_reconstructed = func_reconstruction_filter(t, t_sampled, v_quantised);

% Plot the results
figure
subplot(1,1,1,'XTick',t_sampled,'XGrid','on','YTick',quantisation_levels,'YGrid','on','YLim',[1.25*min(quantisation_levels),1.25*max(quantisation_levels)],'box','on');
hold on
plot(t,v);
stem(t_sampled,v_quantised,'k','LineWidth',2);
plot(t,v_reconstructed,'r--');
xlabel('t [s]');
ylabel('v(t)');
legend('v(t)','sampled and quantised v(t)','reconstructed v(t)','Location','SouthEast');

for symbol_index=1:length(symbols)
    text((symbol_index-1)/f_s,max(quantisation_levels),num2str(symbols(symbol_index)), 'Clipping','on');
end



