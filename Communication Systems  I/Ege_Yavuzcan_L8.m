%%
img = imread('testpat1.png');

Y = im2double(img);

Fs = size(Y,1)*size(Y,2);

%%

img_to_matrix = reshape(Y,1,[]);
t = 0:(1/Fs):(numel(img_to_matrix)-1)/Fs;

N = length(t);
F = linspace(-Fs/2,Fs/2, N);

Mf = abs(fftshift(fft(img_to_matrix, N)))/N;
figure(1);
plot(F, Mf);
title('Magnitude Response of M(f) ');
ylabel(' Magnitude ');
xlabel(' Frequency (Hz )');
legend('|M(f)|');

%% Modulation
kf1 = 100;
kf2 = 400;
fc = 10000;
Ac = 1;

dt=1/Fs;


modulated_1 = Ac*cos((2*pi*fc*t) + (2*pi*kf1*cumsum(img_to_matrix,2)*dt));
modulated_2 = Ac*cos((2*pi*fc*t) + (2*pi*kf2*cumsum(img_to_matrix,2)*dt));

sf1 = fftshift(abs(fft(modulated_1,N)))/N;
sf2 = fftshift(abs(fft(modulated_2,N)))/N;

figure (2)
subplot (211)
plot(F,sf1);
title('Magnitude Response of modulated 1 ');
ylabel(' Magnitude ');
xlabel(' Frequency (Hz)');
legend('|Sf1(f)|');
subplot (212)
plot(F,sf2);
title('Magnitude Response of modulated 2 ');
ylabel(' Magnitude ');
xlabel(' Frequency (Hz)');
legend('|Sf2(f)|');

%%

SNR = [0 25 50];
noise0_modulated1 = awgn(modulated_1,SNR(1),"measured");
noise0_modulated2  = awgn(modulated_2,SNR(1),"measured");
noise25_modulated1 = awgn(modulated_1,SNR(2),"measured");
noise25_modulated2 = awgn(modulated_2,SNR(2),"measured");
noise50_modulated1 = awgn(modulated_1,SNR(3),"measured");
noise50_modulated2 = awgn(modulated_2,SNR(3),"measured");

noise0_f1 = fftshift(abs(fft(noise0_modulated1,N)))/N;
noise0_f2 = fftshift(abs(fft(noise0_modulated2,N)))/N;

figure (3)
subplot (211)
plot(F,sf1);
title('Magnitude Response of noise0 modulated1 ');
ylabel(' Magnitude ');
xlabel(' Frequency (Hz)');
legend('|noise0_f1(f)|');
subplot (212)
plot(F,sf2);
title('Magnitude Response of noise0 modulated2 ');
ylabel(' Magnitude ');
xlabel(' Frequency (Hz)');
legend('|noise0_f2(f)|');

%% demod
Am = max(img_to_matrix);
demod_noise0_1 = fmdemod(noise0_modulated1,fc,Fs,kf1*Am);
demod_noise0_2 = fmdemod(noise0_modulated2,fc,Fs,kf2*Am);
demod_noise25_1  = fmdemod(noise25_modulated1,fc,Fs,kf1*Am);
demod_noise25_2  = fmdemod(noise25_modulated2,fc,Fs,kf2*Am);
demod_noise50_1  = fmdemod(noise50_modulated1,fc,Fs,kf1*Am);
demod_noise50_2  = fmdemod(noise50_modulated2,fc,Fs,kf2*Am);

demod_noise25_1_f1 = fftshift(abs(fft(demod_noise25_1,N)))/N;
demod_noise25_2_f2 = fftshift(abs(fft(demod_noise25_2,N)))/N;
figure (4)
subplot(211)
plot(F,demod_noise25_1_f1);
title('Magnitude Response of demod noise25 with k1 ');
ylabel(' Magnitude ');
xlabel(' Frequency (Hz)');
legend('|demod noise25 with k1(f)|');
subplot(212)
title('Magnitude Response of demod noise25 with k2 ');
ylabel(' Magnitude ');
xlabel(' Frequency (Hz)');
legend('|demod noise25 with k2(f)|');
plot(F,demod_noise25_2_f2);

%%
[b, a] = butter(5, 15000/(Fs/2));

demod_noise0_1_filtered = filter(b,a,demod_noise0_1);
demod_noise0_2_filtered = filter(b,a,demod_noise0_2);
demod_noise25_1_filtered = filter(b,a,demod_noise25_1);
demod_noise25_2_filtered = filter(b,a,demod_noise25_2);
demod_noise50_1_filtered = filter(b,a,demod_noise50_1);
demod_noise50_2_filtered = filter(b,a,demod_noise50_2);

PSNR_noise0_1 = psnr(demod_noise0_1_filtered,img_to_matrix);
PSNR_noise0_2 = psnr(demod_noise0_2_filtered,img_to_matrix);
PSNR_noise25_1 = psnr(demod_noise25_1_filtered,img_to_matrix);
PSNR_noise25_2 = psnr(demod_noise25_2_filtered,img_to_matrix);
PSNR_noise50_1 = psnr(demod_noise50_1_filtered,img_to_matrix);
PSNR_noise50_2 = psnr(demod_noise50_2_filtered,img_to_matrix);
%%
reshaped_img0_1=reshape(demod_noise0_1_filtered,size(Y,1),size(Y,2));
reshaped_img0_2=reshape(demod_noise0_2_filtered,size(Y,1),size(Y,2));
reshaped_img25_1=reshape(demod_noise25_1_filtered,size(Y,1),size(Y,2));
reshaped_img25_2=reshape(demod_noise25_2_filtered,size(Y,1),size(Y,2));
reshaped_img50_1=reshape(demod_noise50_1_filtered,size(Y,1),size(Y,2));
reshaped_img50_2=reshape(demod_noise50_2_filtered,size(Y,1),size(Y,2));

figure (5)

subplot(2,3,1)
imshow(reshaped_img0_1)
title("0 dB AWGN image using kf1")
subplot(2,3,2)
imshow(reshaped_img0_2)
title("0 dB AWGN image using kf2")
subplot(2,3,3)
imshow(reshaped_img25_1)
title("25 dB AWGN image using kf1")
subplot(2,3,4)
imshow(reshaped_img25_2)
title("25 dB AWGN image using kf2")
subplot(2,3,5)
imshow(reshaped_img50_1)
title("50 dB AWGN image using kf1")
subplot(2,3,6)
imshow(reshaped_img50_2)
title("50 dB AWGN image using kf2")

%% mse

MSE0_1 = immse(demod_noise0_1_filtered,img_to_matrix);
MSE0_2 = immse(demod_noise0_2_filtered,img_to_matrix);
MSE25_1 = immse(demod_noise25_1_filtered,img_to_matrix);
MSE25_2 = immse(demod_noise25_2_filtered,img_to_matrix);
MSE50_1 = immse(demod_noise50_1_filtered,img_to_matrix);
MSE50_2 = immse(demod_noise50_2_filtered,img_to_matrix);


SNR = [0 25 50];

figure (6)
MSE_1 = [MSE0_1 MSE25_1 MSE50_1];
MSE_2 = [MSE0_2 MSE25_2 MSE50_2];
plot(SNR,MSE_1);
hold on
plot(SNR,MSE_2);
title('SNR - MSE with k1 and k2 ');
ylabel(' MSE ');
xlabel(' SNR');
legend("kf1","kf2");

%% psnr snr
figure (7)

P1 = [PSNR_noise0_1 PSNR_noise25_1 PSNR_noise50_1];
P2 = [PSNR_noise0_2 PSNR_noise25_2 PSNR_noise50_2];

plot(SNR,P1);
hold on
plot(SNR,P2);
title('SNR - PSNR ');
ylabel(' PSNR');
xlabel(' SNR');
