% Clear Matlab's memory 
clear all

% Seed the random number generator so that everybody is using the same random numbers
randn('seed',5);

% Choose our time base
f_s = 1000; % Sample frequency
t_plot = 10; % Number of seconds to plot in time domain
t_simulate = 100; % Number of seconds to simulate in time domain
f_plot = 20; % Number of Hertz to plot in frequency domain
t = 0:1/f_s:t_simulate; % Time axis
f = 0:f_s/length(t):f_s/2; % Frequency axis

% Set the conditions to impose on the modulated signal
y_amplitude_limit = 5; 
y_lower_freq_limit = 5; % Hz
y_upper_freq_limit = 15; % Hz
y_oob_amplitude_limit = 0.3;
y_dft_limit = y_amplitude_limit*ones(size(f));
y_dft_limit(f<y_lower_freq_limit) = y_oob_amplitude_limit;
y_dft_limit(f>y_upper_freq_limit) = y_oob_amplitude_limit;

% Generate our message signal
f_max = 1; % Choose the maximum frequency for our message signal
x = randn(size(t)); % Generate some noise
x = filter2(fir1(10*ceil(f_s/f_max),2*f_max/f_s),x); % Low pass filter the noise
x = x-mean(x); % Remove any DC offset
x = x/sqrt(mean(x.^2)); % Normalise the signal

% Measure the amplitude spectrum of our message signal
x_dft = 2*abs(fft(x))/length(x);
x_dft = x_dft(1:length(f));

% Plot the message signal and its amplitude spectrum
figure
subplot(2,1,1,'box','on');
plot(t,x);
xlabel('t (in seconds)');
ylabel('x(t)');
ylim([-2.5,2.5])
xlim([0,t_plot])
subplot(2,1,2,'box','on');
plot(f,x_dft);
xlabel('f (in Hertz)');
ylabel('X(f)');
ylim([0,1])
xlim([0,f_plot])

% Use the transmitter to modulate the signal
[y,y_title] = transmitter(x,t);

% Check that the modulated signal has the correct dimensions
if ~isequal(size(y),size(t))
    error('y should have the same dimensions as t');
end

% Measure the amplitude spectrum of our modulated signal
y_dft = 2*abs(fft(y))/length(y);
y_dft = y_dft(1:length(f));
  
% Plot the message signal and its amplitude spectrum
figure
subplot(2,1,1,'box','on');
plot(t,y);
xlabel('t (in seconds)');
ylabel('y(t)');
title(y_title);
ylim([-1.2*max(abs(y)),1.2*max(abs(y))]);
xlim([0,t_plot])
subplot(2,1,2,'box','on');
plot(f,y_dft);
hold on
plot(f,y_dft_limit,'r');
xlabel('f (in Hertz)');
ylabel('Y(f)');
ylim([0,1.1*y_amplitude_limit])
xlim([0,f_plot])

% Check that the amplitude spectrum our modulated signal is not too high
if(max(y_dft > y_dft_limit))
     error('The amplitude spectrum of the modulated signal is not permitted to exceed the limit')
end

% Seed the random number generator so that everybody is using the same random numbers
randn('seed',0);


% Generate some noise
N_0 = 2500;% Choose the noise power
n = sqrt(N_0)*randn(size(t));

% Add the noise to the modulated signal
y_hat = y+n;

% Measure the amplitude spectrum of our modulated signal
y_hat_dft = 2*abs(fft(y_hat))/length(y_hat);
y_hat_dft = y_hat_dft(1:length(f));

% Plot the message signal and its amplitude spectrum
figure
subplot(2,1,1,'box','on');
plot(t,y_hat);
xlabel('t (in seconds)');
ylabel('y_{hat}(t)');
ylim([-1.2*max(abs(y)),1.2*max(abs(y))]);
xlim([0,t_plot])
subplot(2,1,2,'box','on');
plot(f,y_hat_dft);
xlabel('f (in Hertz)');
ylabel('Y_{hat}(f)');
ylim([0,1.1*y_amplitude_limit])
xlim([0,f_plot])

% Use the receiver to demodulate the signal
[x_hat, x_hat_title] = receiver(y_hat,t);

% Check that the demodulated signal has the correct dimensions
if ~isequal(size(x_hat),size(t))
    error('x_hat should have the same dimensions as t');
end

% Measure the amplitude spectrum of our demodulated signal
x_hat_dft = 2*abs(fft(x_hat))/length(x_hat);
x_hat_dft = x_hat_dft(1:length(f));

% Measure the signal to noise ratio of our demodulated signal
error = x-x_hat;
x_hat_snr = 10*log10(1/mean((error(round(0.25*length(error)):round(0.75*length(error)))).^2));
disp(x_hat_snr);

% Plot the demodulated signal and its amplitude spectrum
figure
subplot(2,1,1,'box','on');
plot(t,x_hat);
xlabel('t (in seconds)');
ylabel('x_{hat}(t)');
title(x_hat_title);
ylim([-2.5,2.5])
xlim([0,t_plot])
subplot(2,1,2,'box','on');
plot(f,x_hat_dft);
xlabel('f (in Hertz)');
ylabel('X_{hat}(f)');
annotation('textbox',[0.7,0.3,0.35,0.1],'String',{['SNR = ', num2str(x_hat_snr),' dB']},'LineStyle','none');
ylim([0,1])
xlim([0,f_plot])