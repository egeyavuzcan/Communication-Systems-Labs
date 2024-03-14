%%
img = imread('cameraman.tif');
Y = im2double(img);

Fs = size(Y,1)*size(Y,2);
%%
mt_to_matrix = reshape(Y,1,[]);
t = 0:(1/Fs):(numel(mt_to_matrix)-1)/Fs;

fc = 20000;

ct = cos(2*pi*fc*t);

ka = 0.9;

modulated_signal = (mt_to_matrix*ka + 1).*ct; 

%%
% 0,10,30dB SNR 
P = sum(abs(modulated_signal).^2) / length(modulated_signal);

snr_array = [0 10 30];

SNRlin = [ 10.^(0.1*snr_array(1))  10.^(0.1*snr_array(2))  10.^(0.1*snr_array(3)) ];

var = [ (P/SNRlin(1)) (P/SNRlin(2)) (P/SNRlin(3)) ];

n = [ sqrt(var(1))*randn(1,length(modulated_signal)); sqrt(var(2))*randn(1,length(modulated_signal)); sqrt(var(3))*randn(1,length(modulated_signal))];

r1 = modulated_signal + n(1,:);
r2 = modulated_signal + n(2,:);
r3 = modulated_signal + n(3,:);
%% demodulation

r1_square = r1.^2;
r2_square = r2.^2;
r3_square = r3.^2;

[b, a] = butter(2, 13500/(Fs/2));
r1lowpass = filter(b ,a,r1_square); 
r2lowpass = filter(b,a ,r2_square); 
r3lowpass = filter(b ,a,r3_square); 

r1ustu=sqrt(r1lowpass);
r2ustu=sqrt(r2lowpass);
r3ustu=sqrt(r3lowpass);

r1shift_scale=(r1ustu-max(ct))/ka; 
r2shift_scale=(r2ustu-max(ct))/ka;
r3shift_scale=(r3ustu-max(ct))/ka;

reshaped_r1 = reshape(r1shift_scale,256,256);
reshaped_r2 = reshape(r2shift_scale,256,256);
reshaped_r3 = reshape(r3shift_scale,256,256);

figure (1)
subplot(2,2,1);
imshow(Y);
title("Original reshaped Output");
subplot(2,2,2);
imshow(reshaped_r1);
title("reshaped_r1 with SNR 0");
subplot(2,2,3);
imshow(reshaped_r2);
title("reshaped_r2 with SNR 10");
subplot(2,2,4);
imshow(reshaped_r3);
title("reshaped_r3 with SNR 30");
%%

%MSE = [sum(sum((Y-reshaped_r1).^2 ),2)/numel(Y);sum(sum((Y-reshaped_r2).^2),2)/numel(Y);sum(sum((Y-reshaped_r1).^2),2)/numel(Y)];
mse_r1 = sum(sum((Y-reshaped_r1).^2),2)/numel(Y);
mse_r2 = sum(sum((Y-reshaped_r2).^2),2)/numel(Y);
mse_r3 = sum(sum((Y-reshaped_r3).^2),2)/numel(Y);
MSE = [mse_r1 mse_r2 mse_r3];
figure(2)
plot(snr_array, MSE);
title(" MSE / SNR RATIO");
ylabel('MSE');
xlabel('SNR');
%%