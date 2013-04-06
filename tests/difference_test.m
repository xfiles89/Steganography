clear all;
clc;

steganography_init();

a = '11111111111111111111111111111111';
b = '11000110100101110011001001101110';

limit = 1000;
if length(a) > limit
    a = a(1:limit);
end
if length(b) > limit
    b = b(1:limit);
end

s = [a, ' ', b];
r = str2double(python('difference.py', s)) / 100;
disp(r);

%%
clear variables;
clc;

%a = '0101010001101111001000000101001101101000011001010111001001101100011011110110001101101011001000000100100001101111011011000110110101100101011100110010000001110011011010000110010100100000011010010111001100100000011000010110110001110111011000010111100101110011001000000111010001101000011001010010000001110111011011110110110101100001011011100010111000100000010010010010000001101000011000010111011001100101001000000111001101100101011011000110010001101111011011010010000001101000011001010110000101110010011001000010000001101000011010010110110100100000011011010110010101101110011101000110100101101111011011100010000001101000011001010111001000100000011101010110111001100100011001010111001000100000011000010110111001111001001000000110111101110100011010000110010101110010001000000110111001100001011011010110010100101110001000000100100101101110001000000110100001101001011100110010000001100101011110010110010101110011001000000111001101101000011001010010000001100101011000110110110001101001011100000111001101100101011100110010000001100001011011100110010000100000011100000111001001100101011001000110111101101101011010010110111001100001011101000110010101110011001000000111010001101000011001010010000001110111011010000110111101101100011001010010000001101111011001100010000001101000011001010111001000100000011100110110010101111000001011100010000001001001011101000010000001110111011000010111001100100000011011100110111101110100001000000111010001101000011000010111010000100000011010000110010100100000011001100110010101101100011101000010000001100001011011100111100100100000011001010110110101101111011101000110100101101111011011100010000001100001011010110110100101101110001000000111010001101111001000000110110001101111011101100110010100100000011001100110111101110010001000000100100101110010011001010110111001100101001000000100000101100100011011000110010101110010001011100010000001000001011011000110110000100000011001010110110101101111011101000110100101101111011011100111001100101100001000000110000101101110011001000010000001110100011010000110000101110100001000000110111101101110011001010010000001110000011000010111001001110100011010010110001101110101011011000110000101110010011011000111100100101100001000000111011101100101011100100110010100100000011000010110001001101000011011110111001001110010011001010110111001110100001000000111010001101111001000000110100001101001011100110010000001100011011011110110110001100100001011000010000001110000011100100110010101100011011010010111001101100101001000000110001001110101011101000010000001100001011001000110110101101001011100100110000101100010011011000111100100100000011000100110000101101100011000010110111001100011011001010110010000100000011011010110100101101110011001000010111000100000010010000110010100100000011101110110000101110011001011000010000001001001001000000111010001100001011010110110010100100000011010010111010000101100001000000111010001101000011001010010000001101101011011110111001101110100001000000111000001100101011100100110011001100101011000110111010000100000011100100110010101100001011100110110111101101110011010010110111001100111001000000110000101101110011001000010000001101111011000100111001101100101011100100111011001101001011011100110011100100000011011010110000101100011011010000110100101101110011001010010000001110100011010000110000101110100001000000111010001101000011001010010000001110111011011110111001001101100011001000010000001101000011000010111001100100000011100110110010101100101011011100010110000100000011000100111010101110100001000000110000101110011001000000110000100100000011011000110111101110110011001010111001000100000011010000110010100100000011101110110111101110101011011000110010000100000011010000110000101110110011001010010000001110000011011000110000101100011011001010110010000100000011010000110100101101101011100110110010101101100011001100010000001101001011011100010000001100001001000000110011001100001011011000111001101100101001000000111000001101111011100110110100101110100011010010110111101101110001011100010000001001000011001010010000001101110011001010111011001100101011100100010000001110011011100000110111101101011011001010010000001101111';
%b = '0101010001101111001000000101001101101000011001010111001001101100011011110110001101101011001000000100100001101111011011000110110101100101011100110010000001110011011010000110010100100000011010010111001100100000011000010110110001110111011000010111100101110011001000000111010001101000011001010010000001110111011011110110110101100001011011100010111000100000010010010010000001101000011000010111011001100101001000000111001101100101011011000110010001101111011011010010000001101000011001010110000101110010011001000010000001101000011010010110110100100000011011010110010101101110011101000110100101101111011011100010000001101000011001010111001000100000011101010110111001100100011001010111001000100000011000010110111001111001001000000110111101110100011010000110010101110010001000000110111001100001011011010110010100101110001000000100100101101110001000000110100001101001011100110010000001100101011110010110010101110011001000000111001101101000011001010010000001100101011000110110110001101001011100000111001101100101011100110010000001100001011011100110010000100000011100000111001001100101011001000110111101101101011010010110111001100001011101000110010101110011001000000111010001101000011001010010000001110111011010000110111101101100011001010010000001101111011001100010000001101000011001010111001000100000011100110110010101111000001011100010000001001001011101000010000001110111011000010111001100100000011011100110111101110100001000000111010001101000011000010111010000100000011010000110010100100000011001100110010101101100011101000010000001100001011011100111100100100000011001010110110101101111011101000110100101101111011011100010000001100001011010110110100101101110001000000111010001101111001000000110110001101111011101100110010100100000011001100110111101110010001000000100100101110010011001010110111001100101001000000100000101100100011011000110010101110010001011100010000001000001011011000110110000100000011001010110110101101111011101000110100101101111011011100111001100101100001000000110000101101110011001000010000001110100011010000110000101110100001000000110111101101110011001010010000001110000011000010111001001110100011010010110001101110101011011000110000101110010011011000111100100101100001000000111011101100101011100100110010100100000011000010110001001101000011011110111001001110010011001010110111001110100001000000111010001101111001000000110100001101001011100110010000001100011011011110110110001100100001011000010000001110000011100100110010101100011011010010111001101100101001000000110001001110101011101000010000001100001011001000110110101101001011100100110000101100010011011000111100100100000011000100110000101101100011000010110111001100011011001010110010000100000011011010110100101101110011001000010111000100000010010000110010100100000011101110110000101110011001011000010000001001001001000000111010001100001011010110110010100100000011010010111010000101100001000000111010001101000011001010010000001101101011011110111001101110100001000000111000001100101011100100110011001100101011000110111010000100000011100100110010101100001011100110110111101101110011010010110111001100111001000000110000101101110011001000010000001101111011000100111001101100101011100100111011001101001011011100110011100100000011011010110000101100011011010000110100101101110011001010010000001110100011010000110000101110100001000000111010001101000011001010010000001110111011011110111001001101100011001000010000001101000011000010111001100100000011100110110010101100101011011100010110000100000011000100111010101110100001000000110000101110011001000000110000100100000011011000110111101110110011001010111001000100000011010000110010100100000011101110110111101110101011011000110010000100000011010000110000101110110011001010010000001110000011011000110000101100011011001010110010000100000011010000110100101101101011100110110010101101100011001100010000001101001011011100010000001100001001000000110011001100001011011000111001101100101001000000111000001101111011100110110100101110100011010010110111101101110001011100010000001001000011001010010000001101110011001010111011001100101011100100010000001110011011100000110111101101011011001010010000001101111';

a = '0101010001101111001000000101001101101000011001010111001001101100011011110110001101101011001000000100100001101111011011000110110101100101011100110010000001110011011010000110010100100000011010010111001100100000011000010110110001110111011000010111100101110011001000000111010001101000011001010010000001110111011011110110110101100001011011100010111000100000010010010010000001101000011000010111011001100101001000000111001101100101011011000110010001101111011011010010000001101000011001010110000101110010011001000010000001101000011010010110110100100000011011010110010101101110011101000110100101101111011011100010000001101000011001010111001000100000011101010110111001100100011001010111001000100000011000010110111001111001001000000110111101110100011010000110010101110010001000000110111001100001011011010110010100101110001000000100100101101110001000000110100001101001011100110010000001100101011110010110010101110011001000000111001101101000011001010010000001100101011000110110110001101001011100000111001101100101011100110010000001100001';
b = '0101010001101111001000000101001101101000011001010111001001101100011011110110001101101011001000000100100001101111011011000110110101100101011100110010000001110011011010000110010100100000011010010111001100100000011000010110110001110111011000010111100101110011001000000111010001101000011001010010000001110111011011110110110101100001011011100010111000100000010010010010000001101000011000010111011001100101001000000111001101100101011011000110010001101111011011010010000001101000011001010110000101110010011001000010000001101000011010010110110100100000011011010110010101101110011101000110100101101111011011100010000001101000011001010111001000100000011101010110111001100100011001010111001000100000011000010110111001111001001000000110111101110100011010000110010101110010001000000111001101100001011011010110010100101110001000000100100101101110001000000110100001101001011100110010000001100101011110010110010101110011001000000111001101101000011001010010000001100101011000110110110001101001011100000111001101100101011100110010000001100001';

s = [a, ' ', b];

filename = 'output\temp.txt';
fid = fopen(filename, 'w');
fprintf(fid, '%s', s);
fclose(fid);

r = str2double(python('difference_long.py', filename)) / 100;
disp(r);