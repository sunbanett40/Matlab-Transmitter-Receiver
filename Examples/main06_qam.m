% Script that amplitude modulates an analogue signal

% Choose the time instants in seconds that we want to plot 
plot_frequency = 1000;
t = 0:1/plot_frequency:10;

% Choose a maximum frequency for our signals in Hertz
f_max1 = 10;
f_max2 = 10;

% Use sinusoidal signals
%A = 1;
%phi = 0;
%v1 = cos(2*pi*f_max1*t);
%v2 = cos(2*pi*f_max2*t);

% Use random signals
v1 = func_random_signal(t, f_max1);
v2 = func_random_signal(t, f_max2);

% Choose a modulation sensitivity
k_am = 1;

% Choose a carrier frequency in Hertz
f_c = 100;

% Perform QAM modulation
u = k_am*v1.*cos(2*pi*f_c*t) + k_am*v2.*sin(2*pi*f_c*t);

% Choose a noise power
N_0 = 0;

% Add some noise to our signal
u_received = u + sqrt(N_0)*randn(size(u));

% Perform coherent demodulation
u1_mixed = u_received.*cos(2*pi*f_c*t);
u2_mixed = u_received.*sin(2*pi*f_c*t);

% Choose a cutoff frequency in Hertz
f_cutoff = f_c/2;

% Low pass filter the signal
v1_reconstructed = func_low_pass_filter(t, u1_mixed, f_cutoff);
v2_reconstructed = func_low_pass_filter(t, u2_mixed, f_cutoff);

% Plot the results
figure(1)
subplot(3,3,1,'box','on');
hold on
plot(t(1:1000),v1(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('Message signal 1');
subplot(3,3,2,'box','on');
hold on
plot(t(1:1000),v2(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('Message signal 2');
subplot(3,3,3,'box','on','YLim',[-ceil(max(abs(u(1:1000)))),ceil(max(abs(u(1:1000))))]);
hold on
plot(t(1:1000),u(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('QAM signal');
subplot(3,3,4,'box','on','YLim',[-ceil(max(abs(u(1:1000)))),ceil(max(abs(u(1:1000))))]);
hold on
plot(t(1:1000),u1_mixed(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('Mixed signal 1');
subplot(3,3,5,'box','on','YLim',[-ceil(max(abs(u(1:1000)))),ceil(max(abs(u(1:1000))))]);
hold on
plot(t(1:1000),u2_mixed(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('Mixed signal 2');
subplot(3,3,7,'box','on');
hold on
plot(t(1:1000),v1_reconstructed(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('Reconstructed message signal 1');
subplot(3,3,8,'box','on');
hold on
plot(t(1:1000),v2_reconstructed(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('Reconstructed message signal 2');

figure(2)
subplot(2,2,1,'box','on');
pwelch(v1,[],[],[],plot_frequency);
title('Message signals');
subplot(2,2,2,'box','on');
pwelch(u,[],[],[],plot_frequency);
title('QAM signal');
subplot(2,2,3,'box','on');
pwelch(u1_mixed,[],[],[],plot_frequency);
title('Mixed signals');
subplot(2,2,4,'box','on');
pwelch(v1_reconstructed,[],[],[],plot_frequency);
title('Reconstructed message signals');



figure(1)
