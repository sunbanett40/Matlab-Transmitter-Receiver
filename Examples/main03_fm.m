% Script that frequency modulates an analogue signal

% Choose the time instants in seconds that we want to plot 
t = 0:0.001:10;

% Choose a maximum frequency for our signal in Hertz
f_max = 1;

% Use a sinusoidal signal
%A = 1;
%phi = 0;
%v = cos(2*pi*f_max*t);

% Use a random signal
v = func_random_signal(t, f_max);

% Choose a modulation sensitivity
k_fm = 2;

% Choose a carrier frequency in Hertz
f_c = 10;

% Perform FM modulation
u = cos(2*pi*(f_c + k_fm*v).*t);

% Plot the results
figure
subplot(2,1,1,'box','on');
hold on
plot(t,v);
xlabel('t [s]');
ylabel('v(t)');
subplot(2,1,2,'box','on');
hold on
plot(t,u);
xlabel('t [s]');
ylabel('u(t)');
