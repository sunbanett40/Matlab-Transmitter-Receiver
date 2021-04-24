% Script that phases modulates an analogue signal

% Choose the time instants in seconds that we want to plot 
t = 0:0.001:1;

% Choose a maximum frequency for our signal in Hertz
f_max = 3;

% Use a sinusoidal signal
%A = 1;
%phi = 0;
%v = cos(2*pi*f_max*t);

% Use a random signal
v = func_random_signal(t, f_max);

% Choose a modulation sensitivity
k_pm = 1;

% Determine if the signal is overmodulated
if k_pm*max(v) > pi || k_pm*min(v) < -pi
    disp('Over modulated');
end

% Choose a carrier frequency in Hertz
f_c = 10;

% Perform PM modulation
u = cos(2*pi*f_c*t + k_pm*v);

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
