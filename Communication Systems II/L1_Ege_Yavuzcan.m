t_duration = 0.008;
Fs = 80000;
Ts = 1/Fs;
n = 0:Ts:(0.008-Ts);
f1 =2500;
f2=6000;

x1n = cos(2*pi*f1.*n);
x2n = sin(2*pi*f2.*n);

x3n = x1n + x2n;

x3s_1 = x3n(mod((1:length(n)), 4) == 1);
x3s_2 = x3n(mod((1:length(n)), 12) == 1);

n_1 = 0:(Ts*4):(0.008-Ts); 
n_2 = 0:(Ts*12):(0.008-Ts);

figure(1)
subplot(311);
stem(n, x3n);
title('Original Signal');
ylabel('Amplitude');
xlabel('Time (s)');
legend('x[n]');
subplot(312);
stem(n_1, x3s_1);
title('Downsampled x[n] by 4');
ylabel('Amplitude');
xlabel('Time (s)');
legend('xs[n]_4');
subplot(313);
stem(n_2,x3s_2);
title('Downsampled x[n] by 12');
ylabel('Amplitude');
xlabel('Time (s)');
legend('xs[n]_12');


N = length(n);
N_1 = length(n_1);
N_2 = length(n_2);

FVec = linspace(-Fs/2, Fs/2, N);
FVec_1 = linspace(-Fs/8, Fs/8, N);
FVec_2 = linspace(-Fs/24, Fs/24, N);

X = abs(fftshift(fft(x3n,N)))/N;
XS1 = abs(fftshift(fft(x3s_1,N)))/N;
XS2 = abs(fftshift(fft(x3s_2,N)))/N;

figure(2)
subplot(311);
plot(FVec, X);
title('Magnitude Frequency Response of x[n]');
ylabel('Amplitude');
xlabel('Frequency');
legend('X[f]');
subplot(312);
plot(FVec_1, XS1);
title('Magnitude Frequency Response of xs[n]_4');
ylabel('Amplitude');
xlabel('Frequency');
legend('Xs[f]_4');
subplot(313);
plot(FVec_2, XS2);
title('Magnitude Frequency Response of xs[n]_12');
ylabel('Amplitude');
xlabel('Frequency');
legend('Xs[f]_12');



x1_lin = interp1(n_1,x3s_1,n,'linear');
x1_cub = interp1(n_1,x3s_1,n,'PCHIP');

x2_lin = interp1(n_2,x3s_2,n,'linear');
x2_cub = interp1(n_2,x3s_2,n,'PCHIP');

figure(3)
subplot(211)
plot(n,x3n);
hold on;
plot(n,x1_lin);
hold on;
plot(n,x1_cub);
title('Original signal and reconstructed signal of x[n] downsampled by 4');
ylabel('Amplitude');
xlabel('Time');
legend('x[n]','Linear','Cubic');

subplot(212)
plot(n,x3n);
hold on;
plot(n,x2_lin);
hold on;
plot(n,x2_cub);
title('Original signal and reconstructed signal of x[n] downsampled by 12');
ylabel('Amplitude');
xlabel('Time');
legend('x[n]','Linear','Cubic');

%% Quantization

fs = 80000;
f1 = 2000;
f2 = 400;
t = 0:Ts:(0.008-Ts);
xt = 3*cos(2*pi*f1.*t) + sin(2*pi*f2.*t);
N1 = 4;
N2 = 6;
a = min(xt);
b = max(xt);

quantization_4 = (floor((xt-a)/(b-a)*(2^N1-1)))*(b-a)/(2^N1-1) + a;

quantization_6 = (floor((xt-a)/(b-a)*(2^N2-1)))*(b-a)/(2^N2-1) + a;

figure(4)
subplot(211);
plot(t, xt);
hold on;
plot(t, quantization_4);
title('original and quantize signal x(t) - xq4');
ylabel('Amplitude');
xlabel('Time');
legend('x(t)','xq4');
subplot(212);
plot(t, xt);
hold on;
plot(t, quantization_6);
title('original and quantize signal x(t) - xq6');
ylabel('Amplitude');
xlabel('Time (s)');
legend('x(t)','xq4');


e1 = xt - quantization_4;
e2 = xt - quantization_6;

sqnr1 = 10*log10(var(xt) /  var(e1));
sqnr2 = 10*log10(var(xt) / var(e2));

display(sqnr1);
display(sqnr2);

