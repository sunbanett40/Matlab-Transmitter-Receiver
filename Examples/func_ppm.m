function v_ppm = func_ppm(t, t_sampled, v_sampled, pulse_amplitude, pulse_width, signal_min, signal_max)

    sample_period = (t_sampled(length(t_sampled))-t_sampled(1))/(length(t_sampled)-1);


    v_ppm = zeros(size(t));
    
    for index = 1:length(v_sampled)
        pulse_start = t_sampled(index)+(sample_period-pulse_width)*max(min((v_sampled(index) - signal_min)/(signal_max-signal_min),1),0);
        
        pulse_end = pulse_start+pulse_width;
        
        indices = t >= pulse_start & t < pulse_end;
        
        v_ppm(indices) = pulse_amplitude;
    end
    
end