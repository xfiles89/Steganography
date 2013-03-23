
%% dct
clear all;
clc;

% INPUT
% Data to hide, and image to hide it in
carrier_original = rgb2gray(imread('lena512.jpg'));
secret_msg = str2bin('Test post; please ignore!');


% PROCESS
% Perform encoding
frequency_coefficients = [7 6; 5 2];
[carrier_stego bits_written bits_unused] = steg_encode_dct(secret_msg, carrier_original, frequency_coefficients, 25);

% Write to file and read it again
imwrite(carrier_stego, 'stego.jpg');
carrier_stego = imread('stego.jpg');

% Perform decoding
[retrieved_msg] = steg_decode_dct(carrier_stego, frequency_coefficients);

msg_match = isequal(secret_msg(1:200), retrieved_msg(1:200));
difference = sum((carrier_original - carrier_stego) .^ 2);


% OUTPUT
% Display results
subplot(2,2,1);
imshow(carrier_original);
subplot(2,2,2);
imshow(carrier_stego);

fprintf('Difference: %d\n', sum(difference));

disp(['Encoded message: ', bin2str(secret_msg)]);
disp(['Decoded message: ', bin2str(retrieved_msg)]);

%% zk
clear all;
clc;
clf;

% INPUT
% Data to hide, and image to hide it in
carrier_original = rgb2gray(imread('lena512_2.jpg'));
secret_msg = str2bin('Test post; please ignore!');


% PROCESS
% Define allowed coefficients


% Perform encoding
variance_threshold = 3; % Higher = more blocks used
minimum_distance_encode = 30; % Higher = more robust; more visible
minimum_distance_decode = 10;
frequency_coefficients = generate_allowed_coefficients();%;[4 6; 5 2; 6 5];%[4 3; 3 3; 3 4];
[carrier_stego bits_written bits_unused invalid_blocks_encode debug_invalid_encode] = steg_encode_zk(secret_msg, carrier_original, frequency_coefficients, variance_threshold, minimum_distance_encode);

% Write to file and read it again
imwrite(carrier_stego, 'stego.jpg', 'Quality', 90); % 'Mode', 'lossless'
carrier_stego = imread('stego.jpg');

% Perform decoding
[retrieved_msg invalid_blocks_decode debug_invalid_decode] = steg_decode_zk(carrier_stego, frequency_coefficients, minimum_distance_decode);
carrier_diff = (carrier_original - carrier_stego) .^ 2;

imwrite(carrier_diff, 'diff.jpg');

% OUTPUT
% Display results

limit = 100;
secret_msg_binstr = char(secret_msg(1:limit)+'0');
retrieved_msg_binstr = char(retrieved_msg(1:limit)+'0');
msg_match = isequal(secret_msg(1:200), retrieved_msg(1:200));


subplot(2,3,1);
imshow(carrier_original);
title('Lena (carrier)');
subplot(2,3,2);
imshow(carrier_stego);
title('Lena (stego)');
subplot(2,3,3);
imshow(carrier_diff);
title('Lena (diff^2)');

subplot(2,3,4);
imshow(debug_invalid_encode);
title(sprintf('Invalid encode (%d)', invalid_blocks_encode));
subplot(2,3,5);
imshow(debug_invalid_decode);
title(sprintf('Invalid decode (%d)', invalid_blocks_decode));
subplot(2,3,6);
imshow(~(debug_invalid_encode - debug_invalid_decode));
title('Invalid diff');

disp(['Encoded message (bin): ', secret_msg_binstr]);
disp(['Decoded message (bin): ', retrieved_msg_binstr]);
disp(['Encoded message (str): ', bin2str(secret_msg)]);
disp(['Decoded message (str): ', bin2str(retrieved_msg)]);
if (msg_match)
    disp('SUCCESS: Messages match!');
else
    disp('FAILURE: Messages do not match.');
end

%fprintf('Invalid blocks: (encode=%d) (decode=%d)', invalid_blocks_encode, invalid_blocks_decode);
%%
quality = 25;
imwrite(imread('stego.jpg'), 'stego_e1.jpg', 'Quality', quality); % 'Mode', 'lossless'
for loop = 1:10
    asdf = imread(sprintf('stego_e%d.jpg', loop));
    asdf(loop * 8,1) = 0;
    imwrite(asdf, sprintf('stego_e%d.jpg', loop + 1), 'Quality', quality); % 'Mode', 'lossless'
end

%% Wavelet
% dwt / idwt
clear;
clc;
clf;

im = double(rgb2gray(imread('lena512.jpg')));

mode = 'db1';

[ll lh hl hh] = dwt2(im, mode);%dwt2(im, 'db1');

%{
hhmax = max(max(hh));
hhmin = min(min(hh));
hhavg = hhmax--1;%(hhmax+hhmin);
hh(hh < hhavg) = 0;
%}

frequency_coefficients = [7 6; 5 2];
persistence = 50;

%msg = str2bin('Test post; please ignore!');
msg = str2bin(repmat('ASDF', 1, 128/4));
hh = steg_encode_dct(msg, hh, frequency_coefficients, persistence);
%hl = steg_encode_dct(1-msg, hl, frequency_coefficients, persistence);
%hh = steg_encode_dct(msg, hh, frequency_coefficients, persistence);


abcd = [ll, lh; hl, hh];
im2 = idwt2(ll, lh, hl, hh, mode);

fun_min = 0;
fun_max = 255;%fun_min+10;

subplot(2,2,1);
imshow(super_contrast_fun(im, fun_min, 255-fun_max), [0 255]);
title('original');
subplot(2,2,2);
imshow(abcd, [0 255]);
title('haar transform');

subplot(2,2,3);
imshow(super_contrast_fun(im2, fun_min, 255-fun_max), [0 255]);


%imshow(im2, [0 255]);
%{
a = 0.5;
im2min = double(min(im2(:)))+100;
im2max = double(max(im2(:)))-100;
c = 1;
im2c = (im2-im2min)/(im2max-im2min) * c;
%imshow(im2.^a, [0 255^a]);
imshow(im2c, [0 c]);
%}

title('reconstructed');
subplot(2,2,4);
imshow((im-im2).^2, [0 255]);
title('difference');

q = 94;
imwrite(uint8(im), 'haar_original.jpg', 'Quality', q);
imwrite(uint8(abcd), 'harr_deconstructed.jpg', 'Quality', 75);
imwrite(uint8(im2), 'haar_reconstructed.jpg', 'Quality', q);

im2 = imread('haar_reconstructed.jpg');

[ll2 lh2 hl2 hh2] = dwt2(im2, mode);
message_extracted = bin2str(steg_decode_dct(hh2, frequency_coefficients));
fprintf('Extracted (%d bytes): %s\n', length(message_extracted), message_extracted);

%%
clc;
clear;

fun_min = 0;
fun_max = fun_min+10;

im = double((imread('haar_original.jpg')));
im2 = double((imread('haar_reconstructed.jpg')));

for thing = 1:2:20
    variable_name = 10;
    thingy = thing * variable_name;
    subplot(2,10,thing + 0);
    imshow(super_contrast_fun(im, thingy, 255 - (thingy + variable_name)), [0 255]);
    title('thing + 0');
    subplot(2,10,thing + 1);
    imshow(super_contrast_fun(im2, thingy, 255 - (thingy + variable_name)), [0 255]);
    title('thing + 1');
end