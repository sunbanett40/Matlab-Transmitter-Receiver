% Script that samples a signal

% Choose the time instants in seconds that we want to plot 
t = 0:0.001:1;

% Choose a maximum frequency for our signal in Hertz
f_max = 10;

% Choose a pulse width
pulse_width = 0.01;

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

% Pulse amplitude modulate the samples
v_pam = func_pam(t, t_sampled, v_sampled, pulse_width);

% Plot the results
figure
subplot(1,1,1,'XTick',t_sampled,'XGrid','on','box','on');
hold on
plot(t,v,'b');
plot(t,v_pam,'k');
xlabel('t [s]');
ylabel('v(t)');
legend('v(t)','v_{pam}(t)');

