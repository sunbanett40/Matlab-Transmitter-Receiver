% Script that amplitude modulates an analogue signal

% Choose the time instants in seconds that we want to plot 
plot_frequency = 1000;
t = 0:1/plot_frequency:10;

% Choose a maximum frequency for our signal in Hertz
f_max = 10;

% Use a sinusoidal signal
%A = 1;
%phi = 0;
%v = cos(2*pi*f_max*t);

% Use a random signal
v = func_random_signal(t, f_max);

% Choose a modulation sensitivity
k_am = 1;

% Choose a carrier frequency in Hertz
f_c = 100;

% Perform SSBSC modulation
u = k_am*v.*cos(2*pi*f_c*t) - k_am*imag(hilbert(v)).*sin(2*pi*f_c*t);

% Choose a noise power
N_0 = 0;

% Add some noise to our signal
u_received = u + sqrt(N_0)*randn(size(u));

% Perform coherent demodulation
u_mixed = u_received.*cos(2*pi*f_c*t);

% Choose a cutoff frequency in Hertz
f_cutoff = f_c/2;

% Low pass filter the signal
v_reconstructed = func_low_pass_filter(t, u_mixed, f_cutoff);

% Plot the results
figure(1)
subplot(2,2,1,'box','on');
hold on
plot(t(1:1000),v(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('Message signal');
subplot(2,2,2,'box','on','YLim',[-ceil(max(abs(u(1:1000)))),ceil(max(abs(u(1:1000))))]);
hold on
plot(t(1:1000),u(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('SSBSC signal');
subplot(2,2,3,'box','on','YLim',[-ceil(max(abs(u(1:1000)))),ceil(max(abs(u(1:1000))))]);
hold on
plot(t(1:1000),u_mixed(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('Mixed signal');
subplot(2,2,4,'box','on');
hold on
plot(t(1:1000),v_reconstructed(1:1000));
xlabel('t [s]');
ylabel('amplitude');
title('Reconstructed message signal');

figure(2)
subplot(2,2,1,'box','on');
pwelch(v,[],[],[],plot_frequency);
title('Message signal');
subplot(2,2,2,'box','on');
pwelch(u,[],[],[],plot_frequency);
title('SSBSC signal');
subplot(2,2,3,'box','on');
pwelch(u_mixed,[],[],[],plot_frequency);
title('Mixed signal');
subplot(2,2,4,'box','on');
pwelch(v_reconstructed,[],[],[],plot_frequency);
title('Reconstructed message signal');



figure(1)
