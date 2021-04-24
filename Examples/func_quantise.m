function symbols = func_quantise(v_sampled, quantisation_levels)

    % Initialise some storage for the quantisation errors
    errors = zeros(length(quantisation_levels), length(v_sampled));

    % Calculate the quantisation errors
    for i =1:length(quantisation_levels)
        errors(i,:) = abs(v_sampled-quantisation_levels(i));              
    end

    % Choose the quantisation levels that give the minimum error
    [min_error, symbols] = min(errors);
    
    % Start the symbol values from 0, rather than 1
    symbols = symbols-1;

end