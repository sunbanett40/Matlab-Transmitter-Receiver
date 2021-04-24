function v_reconstructed = func_low_pass_filter(t, u, f_cutoff)

    % Determine the orignal sampling frequency
    f_s = (length(t)-1)/(t(length(t))-t(1));

    % Setup a low pass filter to reconstruct the signal
    B = fir1(100*ceil(f_s/f_cutoff), 2*f_cutoff/f_s);

    % Filter the sampled signal
    v_reconstructed = filter2(B,u);
    
end