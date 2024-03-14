
f1 = 50
f2 = 200
f3 = 500
fs = 5000
t=-0.05:1/fs:0.05

x= 0.1*sin(2*pi*f1.*t) + 0.5*cos(2*pi*f2.*t) -0.9*sin(2*pi*f3.*t);

figure(1)
plot(t,x)
title("x(t)")
legend("x(t)")
xlabel("Time")
ylabel("X")

%%
T = 1 /fs
N = length(x)
%f= 0:1:500;
f = linspace(-fs/2,fs/2,N)
%f = fs*(0:(N/2))/N;
xfft = fft(x,N)
xfft = fftshift(xfft)
xfft= abs(xfft)/500;
figure(2)
subplot(2,1,1)
plot(f,abs(xfft))
title("X(F)")
legend("X(F)")
xlabel("Freq")
ylabel("Xfft")
subplot(2,1,2)
plot(t,x)
title("x(t)")
legend("x(t)")
xlabel("Time")
ylabel("X")

%%
figure (3)
subplot(3,1,1)
Fs = 5000
[b_1_1, a_1_1] = butter(1,75/(Fs/2),"low");
[h,w] = freqz(b_1_1,a_1_1,Fs/2); 
plot(abs(h));
hold on
[b1,a1] = butter(7,75/ (Fs/2),"low");
[h,w] = freqz(b1,a1,Fs/2);
plot(abs(h));
legend("n = 1 ","n = 7")
title ("Low-pass Filter")
subplot(3,1,2)
[b_1_2,a_1_2]= butter(1,350/(Fs/2),"high");
[h,w]=freqz(b_1_2,a_1_2,Fs/2);
plot(abs(h));
hold on
[b2,a2]= butter(7,350/(Fs/2),"high");
[h,w]=freqz(b2,a2,Fs/2);
plot(abs(h));
legend("n = 1","n = 7")
title ("High-pass Filter")
subplot(3,1,3)
[b_1_3,a_1_3]= butter(1,[75 350]/(Fs/2),"bandpass");
[h,w]=freqz(b_1_3,a_1_3,Fs/2);
plot(abs(h));
hold on
[b3,a3]= butter(7,[75 350]/(Fs/2),"bandpass");
[h,w]=freqz(b3,a3,Fs/2);
plot(abs(h));
legend(" n = 1"," n = 7")
title ("Band-pass Filter")

%%
lowpas=filter(b1,a1,x)
highpas = filter(b2,a2,x)
bandpas = filter (b3,a3,x)

figure(4)
subplot(4,1,1)
plot(f,xfft)
legend("x(f)")
title ("X(F)")
xlabel("Freq")


subplot(4,1,2)

lowpas = fft(lowpas,N)
lowpas = fftshift(lowpas)
lowpas= abs(lowpas)/500;
plot(f,abs(lowpas))
legend("Low-pass Filter")
xlabel("Freq")
ylabel("Low")
title ("Low-pass Filter")
subplot(4,1,3)

highpas = fft(highpas,N)
highpas = fftshift(highpas)
highpas= abs(highpas)/500;

plot(f,abs(highpas))
legend("High-pass Filter")
xlabel("Freq")
ylabel("High")
title("High-pass Filter")
subplot(4,1,4)
bandpas = fft(bandpas,N)
bandpas = fftshift(bandpas)
bandpas= abs(bandpas)/500;
plot(f,abs(bandpas))
legend("Band-pass Filter")
xlabel("Freq")
ylabel("Band")
title("Band-pass Filter")
