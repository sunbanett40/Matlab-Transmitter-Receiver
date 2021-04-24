function v_pwm = func_pwm(t, t_sampled, v_sampled, pulse_amplitude, signal_min, signal_max)

    sample_period = (t_sampled(length(t_sampled))-t_sampled(1))/(length(t_sampled)-1);


    v_pwm = zeros(size(t));
    
    for index = 1:length(v_sampled)
        indices = t >= t_sampled(index) & t < t_sampled(index)+sample_period*min((v_sampled(index) - signal_min)/(signal_max-signal_min),1);
        
        v_pwm(indices) = pulse_amplitude;
    end
    
end