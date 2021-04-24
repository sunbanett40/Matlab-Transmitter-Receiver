function v_quantised = func_dequantise(symbols, quantisation_levels)
    
    % Output the quantisation levels identified by the symbols
    v_quantised = quantisation_levels(symbols+1);

end