%% DSB-SC modulation
t_end = 0.1;
fm = 50;
fc = 1000;
Fs = 50000;
phase = 0;
Am = 2;
Ac = 1;

t = 0:1/Fs:t_end;

m = Am*cos(2*pi*fm*t);
c = Ac*cos(2*pi*fc*t+phase);

s = m.*c; %modulation

figure(1)
subplot(2,1,1);
plot(t,m,t,c);
title('m(t) and c(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('m(t)','c(t)');
subplot(2,1,2);
plot(t,s);
title('s(t) modulated signal');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s(t)');

%% demod
Ac_prime = max(s)
modulation_signal = Ac_prime*cos(2*pi*fc*t+phase);
u = s.*modulation_signal;

%using buttord to determine fcutt off and order of filter
[n, wc] = buttord(fm/(Fs/2), fc/(Fs/2), 1, 30);
[b_2,a_2]=butter(n,wc); 
u_filtered_2=filter(b_2,a_2,u);

figure(3)
plot(t,u_filtered_2,t,m)
title('m(t) and y(t)');
ylabel('Amplitude ');
xlabel('Time (s)');
legend('y(t)',"m(t)");



%% 


N = length(t);
f = linspace(-Fs/2,Fs/2, N);
S = abs(fftshift(fft(s,N)))/N;
M = abs(fftshift(fft(m,N)))/N;
U = abs(fftshift(fft(u,N)))/N;

figure(2)
subplot(3,1,1);
plot(f,M);
title('|M(f)|');
ylabel('Magnitude');
xlabel('Frequency (Hz)');
legend('M(f)');
subplot(3,1,2);
plot(f,S);
title('|S(f)|');
ylabel('Magnitude');
xlabel('Frequency (Hz)');
legend('S(f)');
subplot(3,1,3);
plot(f,U);
title('|U(f)|');
ylabel('Magnitude');
xlabel('Frequency (Hz)');
legend('U(f)');



%% SSB

[b,a] = butter(5,[1000,2000]/(Fs/2),"bandpass");
su = filter(b,a,s);
[h,w] = freqz(b,a,Fs/2)

SUF = abs(fftshift(fft(su,N)))/N;
figure(4)
subplot(2,1,1)
plot(abs(h))
ylabel("Magnitude")
xlabel("Frequency (Hz)")
title('Magnitude Response of Band-pass Filter');

subplot(2,1,2)
plot(f,SUF)
ylabel("Magnitude");
xlabel("Frequency (Hz)");
title('|Su(F)|');
legend('|Su(F)|');


