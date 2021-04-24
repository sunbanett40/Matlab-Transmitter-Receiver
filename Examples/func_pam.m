function v_pam = func_pam(t, t_sampled, v_sampled, pulse_width)


    v_pam = zeros(size(t));
    
    for index = 1:length(v_sampled)
        indices = t >= t_sampled(index) & t < t_sampled(index)+pulse_width;
        v_pam(indices) = v_sampled(index)
    end
    
end