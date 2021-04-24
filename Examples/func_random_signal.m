function v=func_random_signal(t,f_max)

    % Determine the sampling frequency
    f_s = (length(t)-1)/(t(length(t))-t(1));

    % Generate a white Gaussian noise signal
    v = randn(size(t));
    
    if(f_s > 2*f_max)
        % Setup a low pass filter to bandlimit the noise
        B = fir1(100*ceil(f_s/f_max), 2*f_max/f_s);

        % Filter the noise signal
        v = filter2(B,v);
        
        % Normalise the signal
        v = v*sqrt(length(t)/sum(v.^2));
    end
        
end

