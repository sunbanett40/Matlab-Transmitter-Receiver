% Script that generates sinusoidal and random signals

% Choose the time instants in seconds that we want to plot 
t = 0:0.001:1;

% Choose a maximum frequency for our signal in Hertz
f_max = 10;

% Use a sinusoidal signal
%A = 1;
%phi = 0;
%v = cos(2*pi*f_max*t);

% Use a random signal
v = func_random_signal(t, f_max);

% Plot the results
plot(t,v);
xlabel('t [s]');
ylabel('v(t)');

[t' v']