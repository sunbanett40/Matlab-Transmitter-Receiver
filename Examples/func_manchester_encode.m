function [t_new,u] = func_manchester_encode(t, bits, bit_rate)

    % Determine the sampling frequency
    f_s = (length(t)-1)/(t(length(t))-t(1));

    % Determine a new set of time instants to accommodate any extra bits
    t_new = t(1):1/f_s:((round(length(bits)*f_s/bit_rate))/f_s+t(1));    
    
    % Allocate memory for the Manchester signal
    u = zeros(size(t_new));
    
    % Determine the Manchester signal value for each bit period
    for i = 1:length(bits)
        u((round((i-1)*f_s/bit_rate)+1):(round((i-0.5)*f_s/bit_rate))) = bits(i);
        u((round((i-0.5)*f_s/bit_rate)+1):(round(i*f_s/bit_rate))) = (1-bits(i));
    end
    
end