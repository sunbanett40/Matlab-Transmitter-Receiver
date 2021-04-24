% Script that M-ary phase shift keying modulates a quantised signal

% Choose the time instants in seconds that we want to plot 
t = 0:0.001:1;

% Choose a maximum frequency for our signal in Hertz
f_max = 3;

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

quantisation_levels = [-2.7326 -2.0690 -1.6181 -1.2562 -0.9423 -0.6568 -0.3880 -0.1284 0.1284 0.3880 0.6568 0.9423 1.2562 1.6181 2.0690 2.7326];

% Perform quantisation
symbols = func_quantise(v_sampled, quantisation_levels);

% Determine the number of bits per symbol
k = ceil(log2(length(quantisation_levels)));

% Perform pulse coded modulation
bits = func_pulse_coded_modulation(symbols, k);

% 16-QAM    M=16 k=4       I = (2*b1-1)*(3-2*b2)   Q = -(2*b3-1)*(3-2*b4)
%
%                        I      Q             b1  b2  b3  b4    
constellation_points = [-3      3;... %       0   0   0   0
                        -1      3;... %       0   0   0   1
                         3      3;... %       0   0   1   0
                         1      3;... %       0   0   1   1
                        -3     -3;... %       0   1   0   0
                        -1     -3;... %       0   1   0   1
                         3     -3;... %       0   1   1   0
                         1     -3;... %       0   1   1   1
                        -3      1;... %       1   0   0   0
                        -1      1;... %       1   0   0   1
                         3      1;... %       1   0   1   0
                         1      1;... %       1   0   1   1
                        -3     -1;... %       1   1   0   0
                        -1     -1;... %       1   1   0   1
                         3     -1;... %       1   1   1   0
                         1     -1];   %       1   1   1   1
         
% Determine M-ary
M = size(constellation_points, 1);

% Choose bits per modulation symbol
k2 = log2(M);


% Perform pulse coded modulation
symbols2 = func_pulse_coded_demodulation(bits, k2);

% Determine modulation symbol rate
f_m = f_s*k/k2;

% Perform NRZ encoding
[t_new,u] = func_nrz_encode(t, symbols2, f_m);

% Determine in-phase message signal
v_mi = constellation_points(u+1,1);

% Determine quadrature-phase message signal
v_mq = constellation_points(u+1,2);



% Choose carrier frequency
f_c = 40;

% Perform PSK modulation
u2 = v_mi'.*cos(2*pi*f_c*t_new) - v_mq'.*sin(2*pi*f_c*t_new);

% Perform dequantisation
v_quantised = func_dequantise(symbols, quantisation_levels);

% Plot the constellation diagram
figure
subplot(1,1,1,'XTick',[-1,0,1],'YTick',[-1,0,1],'XGrid','on','YGrid','on','XLim',[-1.25*max(constellation_points(:,1)),1.25*max(constellation_points(:,1))], 'YLim',[-1.25*max(constellation_points(:,1)),1.25*max(constellation_points(:,1))],'box','on');
hold on
plot(constellation_points(:,1),constellation_points(:,2),'MarkerFaceColor',[0 0 0],'MarkerEdgeColor',[0 0 0],...
    'MarkerSize',20,...
    'Marker','.',...
    'LineStyle','none');

for i = 1:size(constellation_points,1)
    text(constellation_points(i,1),constellation_points(i,2)+max(constellation_points(:,1))/10, dec2bin(i-1,k2), 'HorizontalAlignment', 'center');
end
axis square
xlabel('I');
ylabel('Q');



% Plot the results
figure
subplot(2,1,1,'XTick',t_sampled,'XGrid','on','YTick',quantisation_levels,'YGrid','on','YLim',[1.25*min(quantisation_levels),1.25*max(quantisation_levels)],'box','on');
hold on
plot(t,v);
stem(t_sampled,v_quantised,'k','LineWidth',2);
xlabel('t [s]');
ylabel('v(t)');
legend('v(t)','sampled and quantised v(t)','Location','SouthEast');

for symbol_index=1:length(symbols)
    text((symbol_index-1)/f_s,max(quantisation_levels),regexprep(num2str(bits(((symbol_index-1)*k+1:min(symbol_index*k,length(bits))))),' ',''), 'Clipping','on');
end


amplitudes = sqrt(constellation_points(:,1).^2+constellation_points(:,2).^2);
subplot(2,1,2,'XTick',0:1/f_m:max(t),'XGrid','on','YTick',unique([-amplitudes;amplitudes]), 'YLim',[-1.25*max(amplitudes),1.25*max(amplitudes)] ,'YGrid','on','box','on');
hold on
plot(t,u2(1:length(t)));
xlabel('t [s]');
ylabel('u(t)');

for symbol_index=1:length(symbols2)
    text((symbol_index-0.5)/f_m,max(amplitudes),regexprep(num2str(bits(((symbol_index-1)*k2+1:min(symbol_index*k2,length(bits))))),' ',''), 'HorizontalAlignment', 'center','Clipping','on');
end

