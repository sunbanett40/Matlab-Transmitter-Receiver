% PCM encode a sequence of symbols, in order to generate a sequence of bits
% symbols - a vector of K integers, in the range 0 to M-1
% bits_per_symbol - the number of bits per symbol, given by log2(M)
% bits - a vector of K*bits_per_symbol bits
function bits = pcm_encode(symbols, bits_per_symbol)

% Create some memory to store the bits
bits = zeros(bits_per_symbol,length(symbols));

% For each symbol, generate the corresponding sequence of bits
for symbol_index = 1:length(symbols);
    bits(:,symbol_index) = dec2bin(symbols(symbol_index),bits_per_symbol)-'0';
end

% Arrange the bits into a long vector
bits = reshape(bits,1,numel(bits));