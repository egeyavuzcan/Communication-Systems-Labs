clc;
clear all;

f1 = 20;
f2 = 50; %frequency values
f3 = 1000;
f4 = 5000;
fs = 20000;
t = 0:1/fs:0.5;

x = 5* sin(2*pi*f1.*t) + cos(2*pi*f2.*t) + 15 *cos(2*pi*f3.*t) + 10*cos(2*pi*f4.*t) % function definition

N = length(x)
x_fft = fft(x,N) %ft and frequency matrix definition using elnght of x and sampling freq
f = linspace(-fs/2,fs/2,N)

figure(1)
%plotting signal and signals frequency response
subplot(2,1,1)
plot(t,x);
legend("x(t)")
xlabel('Time (s)');
ylabel('Amplitude');
title('Input Signal x(t)');
subplot(2,1,2)
plot(f,fftshift(abs(x_fft)/length(x_fft))) %normalization
legend("x(f)")
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Frequency Response of x(t)');
grid on;
%%
fc= 35; %determine cutoff frequency by analyzing min-max frequencies

[b_1, a_1] = butter(7,fc/(fs/2),"low"); %using 7th filter order 
[h_1,w_1] = freqz(b_1,a_1,fs/2); 
figure(2)
subplot(3,1,1)
plot(abs(h_1))
ylabel("Magnitude")
xlabel("Frequency (Hz)")
title('Magnitude Response of Low-pass Filter');

fc_2 = 3000;
[b_2,a_2] = butter(7,fc_2/(fs/2),"high");
[h_2,w_2] = freqz(b_2,a_2,fs/2)
subplot(3,1,2)
plot(abs(h_2))
ylabel("Magnitude")
xlabel("Frequency (Hz)")
title('Magnitude Response of High-pass Filter');

fc_3=800
[b_3,a_3] = butter(7,[fc_3,1200]/(fs/2),"bandpass");
[h_3,w_3] = freqz(b_3,a_3,fs/2);
subplot(3,1,3)
plot(abs(h_3))
ylabel("Magnitude")
xlabel("Frequency (Hz)")
title('Magnitude Response of Band-pass Filter');
grid on;
%%

lowpas=filter(b_1,a_1,x)
highpas = filter(b_2,a_2,x)
bandpas = filter (b_3,a_3,x)

%plotting frequency responses of all filters with normalization
figure(3)
subplot(2,2,1)
plot(f,fftshift(abs(x_fft)/length(x_fft)))
legend("x(f)")
title ("X(F)")
ylabel("Magnitude")
xlabel("Frequency (Hz)")
title('Frequency Response of x(t)');

subplot(2,2,2)

lowpas = fft(lowpas,N)
lowpas = fftshift(lowpas)
lowpas= abs(lowpas)/length(lowpas);
plot(f,abs(lowpas))
legend("Low-pass Filter")
xlabel("Frequency (Hz)")
ylabel("Magnitude")
title('Frequency Response of Low-pass Filter');
subplot(2,2,3)

highpas = fft(highpas,N)
highpas = fftshift(highpas)
highpas= abs(highpas)/length(highpas);

plot(f,abs(highpas))
legend("High-pass Filter")
xlabel("Frequency (Hz)")
ylabel("Magnitude")
title('Frequency Response of High-pass Filter');
subplot(2,2,4)
bandpas = fft(bandpas,N)
bandpas = fftshift(bandpas)
bandpas= abs(bandpas)/length(bandpas);
plot(f,abs(bandpas))
legend("Band-pass Filter")
xlabel("Freq")
ylabel("Magnitude")
title('Frequency Response of Band-pass Filter');