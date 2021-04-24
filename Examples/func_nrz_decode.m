function recovered_bits = func_nrz_decode(t, u, bit_rate)

    % Determine the sampling frequency
    f_s = (length(t)-1)/(t(length(t))-t(1));

    % Allocate memory for the bit sequence
    recovered_bits = zeros(1, round(length(u)*bit_rate/f_s));
    
    % Decide if the signal value in each bit period corresponds to a 0 or a 1
    for i = 1:length(recovered_bits)
        recovered_bits(i) = mean(u((round((i-1)*f_s/bit_rate)+1):(round(i*f_s/bit_rate)))>0.5)>0.5;
    end

end