function [t_sampled,v_sampled] = func_sample(t,v,f_s)

    % Determine the orignal sampling frequency
    f_s_old = (length(t)-1)/(t(length(t))-t(1));
   
    % Perform the sampling
    t_sampled = downsample(t,round(f_s_old/f_s));

    % Perform the sampling
    v_sampled = downsample(v,round(f_s_old/f_s));

end
