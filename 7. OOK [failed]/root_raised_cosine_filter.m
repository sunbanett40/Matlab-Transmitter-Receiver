% Root raised cosine filter an input signal, in order to obtain the output signal
% input - a vector of L real values, K of which will be regularly-spaced
%    non-zero values, the rest of which will have the value zero
% t - a vector of L regularly-spaced time instants
% f_symbol - the symbol rate in Hertz, which is given by (K-1)/(max(t)-min(t))
% output - the filtered vector of L real values
function output = root_raised_cosine_filter(input, t, f_symbol)

% We need to work out the sample rate of the input signal 
f_s = (length(t)-1)/(t(end)-t(1));

% Design the raised cosine filter
D = fdesign.pulseshaping(round(f_s/f_symbol),'Square Root Raised Cosine','Nsym,Beta',10,0);
H = design(D);
B = tf(H);

% Apply the raised cosine filter to the input signal
output = filter2(B,input);