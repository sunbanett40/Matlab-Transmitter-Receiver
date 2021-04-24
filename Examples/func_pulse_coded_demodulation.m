function recovered_symbols = func_pulse_coded_demodulation(bits, k)

    % Allocate some memory for the symbol sequence
    recovered_symbols = zeros(1,length(bits)/k);
    
    % Perform PCM
    for i = 1:length(recovered_symbols)
        recovered_symbols(i) = bin2dec(char(bits((k*(i-1)+1):(k*i))+48)); % +48 converts from bit vector to ASCII vector
    end

end