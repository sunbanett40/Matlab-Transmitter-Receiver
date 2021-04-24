function bits = func_pulse_coded_modulation(symbols, k)

    % Allocate some memory for the bit sequence
    bits = zeros(1,length(symbols)*k);
    
    % Perform PCM
    for i = 1:length(symbols)
        bits((k*(i-1)+1):(k*i)) = dec2bin(symbols(i),k)-48; % -48 converts from ASCII vector to bit vector
    end

end