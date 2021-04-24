function v_reconstructed = func_reconstruction_filter(t, t_sampled, v_sampled)

    % Determine the orignal sampling frequency
    f_s_old = (length(t)-1)/(t(length(t))-t(1));

    % Determine the sampling frequency
    f_s = (length(t_sampled)-1)/(t_sampled(length(t_sampled))-t_sampled(1));

    % Upsample the sampled signal
    v_reconstructed = upsample(v_sampled, round(f_s_old/f_s));
    
    % Normalise the sampled signal
    v_reconstructed = round(f_s_old/f_s)*v_reconstructed(1:length(t));
   
    % Setup a low pass filter to reconstruct the signal
    B = fir1(100*ceil(f_s_old/f_s), f_s/f_s_old);

    % Filter the sampled signal
    v_reconstructed = filter2(B,v_reconstructed);
    
end