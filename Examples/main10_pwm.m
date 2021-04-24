% Script that samples a signal

% Choose the time instants in seconds that we want to plot 
t = 0:0.001:1;

% Choose a maximum frequency for our signal in Hertz
f_max = 10;

% Choose a pulse width
pulse_amplitude = 1;
signal_min = -2;
signal_max = +2;

% Use a sinusoidal signal
%A = 1; % Amplitude
%phi = 0; % Phase in the range 0 to 2*pi
%v = A*cos(2*pi*f_max*t + phi);

% Use a random signal
v = func_random_signal(t, f_max);

% Choose a sampling frequency in Hertz
f_s = 25;

% Sample the signal
[t_sampled, v_sampled] = func_sample(t, v, f_s);

% Pulse width modulate the samples
v_pwm = func_pwm(t, t_sampled, v_sampled, pulse_amplitude, signal_min, signal_max);

% Reconstruct the samples
v_sampled2 = min(max(v_sampled,signal_min),signal_max);

% Low pass filter the samples to reconstruct the signal
v_reconstructed = func_reconstruction_filter(t, t_sampled, v_sampled2);


% Plot the results
figure
subplot(1,1,1,'XTick',t_sampled,'XGrid','on','box','on');
hold on
plot(t,v,'b');
plot(t,v_pwm,'k');
plot(t,v_reconstructed,'r--');
xlabel('t [s]');
ylabel('v(t)');
legend('v(t)','v_{pwm}(t)','reconstructed v(t)');

