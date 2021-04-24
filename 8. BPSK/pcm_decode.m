% PCM decode a sequence of bits, in order to generate a sequence of symbols
% bits - a vector of K*bits_per_symbol bits
% bits_per_symbol - the number of bits per symbol, given by log2(M)
% symbols - a vector of K integers, in the range 0 to M-1
function symbols = pcm_decode(bits, bits_per_symbol)

% Create memory to store our symbols
symbols = zeros(1,length(bits)/bits_per_symbol);

% Arrange the bits into groups comprising bits_per_symbol numer of bits
bits = reshape(bits, bits_per_symbol, length(symbols));

% For each symbol, decode the corresponding bits
for symbol_index = 1:length(symbols)
    symbols(symbol_index) = bin2dec(num2str(bits(:,symbol_index)'));
end
    
