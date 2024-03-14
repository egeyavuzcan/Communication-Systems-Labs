clearvars; clc; close all;
d = 2; 
load handel.mat
filename = 'handel.flac';
audiowrite(filename,y,Fs);
samples = [1,d*Fs];
clear Fs
[x,Fs] = audioread(filename,samples); 
soundsc(x);


t=0:1/Fs:d;


x1= zeros(1,(length(t)-1)/4)
x = transpose(x)
a = 1
for i=1:4:length(t)-1
    x1(a) = x(i);
    a = a + 1;
end

x2= zeros(1,(length(t)-1)/8)
b=1
for j=1:8:length(t)-1
    x2(b) = x(j);
    b = b + 1;
end

Fs1 = Fs / 4
Fs2 = Fs / 8
figure(1)

xfft = fft(x,length(x))
xfft = fftshift(xfft)
xfft= abs(xfft)/length(x);
subplot(3,1,1)

f = -(Fs/2):1/d:Fs/2-0.0001;
plot(f,xfft)

x1fft = fft(x1,length(x1))
x1fft = fftshift(x1fft)
x1fft= abs(x1fft)/length(x1);
subplot(3,1,2)
f1 = -(Fs1/2):1/d:Fs1/2-0.0001;
plot(f1,x1fft)

x2fft = fft(x2,length(x2))
x2fft = fftshift(x2fft)
x2fft= abs(x2fft)/length(x2);
subplot(3,1,3)
f2 = -(Fs2/2):1/d:Fs2/2-0.0001;
plot(f2,x2fft)

t=0:1/Fs:d-0.0001;

t1_1=0:1/(Fs):d-0.0001;
t1_2=0:1/(Fs):d-0.0001;
t1_3=0:1/(Fs):d-0.0001;

t1=0:1/Fs1:d-1/(4*Fs1);
t2=0:1/Fs2:d-1/(8*Fs2);
x_inter = interp1(t,x,t1_1,"linear");
x1_inter=interp1(t1,x1,t1_2,"linear");
x2_inter=interp1(t2,x2,t1_3,"linear");
figure(2)
subplot(3,1,1)
plot(t1_1,x_inter)
title(" X(t)")
subplot(3,1,2)
plot(t1_2,x1_inter)
title(" X1[n] İnterpole")
subplot(3,1,3)
plot(t1_3,x2_inter)
title(" X2[n] İnterpole")
