p = 10;
fm = 50;
Am = 1;
Fs = 2000;
T = p*(1/fm);
t = 0:1/Fs:T-1/Fs;
mt = sawtooth(2*pi*fm*t);

fc  = 200;
Ac = 1;

Ts = 1/Fs;


ct = Ac*cos(2*pi*fc*t);
%mt = Am*cos(2*pi*fm*t);

figure(1);
subplot(2,1,1);
plot(t, mt);
title('m(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('m(t)');
subplot(2,1,2);
plot(t, ct);
title('c(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('c(t)');

%%

% deltaf/fm = 1 threshold value of B , 1.5 and 0.5 times of B equals to
% deltaf/fm = 1.5 and deltaf/fm = 0.5 , we can use kf/fm = deltaf/fm, so we
% can calcutae kf1 = 75 and kf2 = 25

kf1 = 75;
kf2 = 25;

dt = Ts;
s1t = Ac*cos((2*pi*fc*t) + (2*pi*kf1*cumsum(mt,2)*dt));
s2t = Ac*cos((2*pi*fc*t) + (2*pi*kf2*cumsum(mt,2)*dt));
figure(2);
subplot(2,1,1);
plot(t, s1t);
title('s1(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s1(t)');
subplot(2,1,2);
plot(t, s2t);
title('s2(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s2(t)');

%%

N = length(t);
F = linspace(-Fs/2,Fs/2, N);

Mf = abs(fftshift(fft(mt, N)))/N;
Cf = abs(fftshift(fft(ct, N)))/N;

figure(3);
subplot(2,1,1);
plot(F, Mf);
title('Magnitude Response of M(f) ');
ylabel(' Magnitude ');
xlabel(' Frequency (Hz )');
legend('|M(f)|');
subplot(2,1,2);
plot(F, Cf);
title(' Magnitude Response of C(f)');
ylabel(' Magnitude ');
xlabel('Frequency (Hz)');
legend('|C(f)|');

S1f = fftshift(fft(s1t, N))/N;
S2f = fftshift(fft(s2t, N))/N;

figure(4);
subplot(2,1,1);
plot(F, S1f);
title(' Frequency Response S1(f)');
ylabel(' Magnitude ');
xlabel(' Frequency (Hz )');
legend('S1(f)');
subplot(2,1,2);
plot(F, S2f);
title(' Frequency Response S2(f)');
ylabel(' Magnitude ');
xlabel('Frequency (Hz)');
legend('S2(f)');

%%
demods1 = Am*fmdemod(s1t,fc,Fs,Am*kf1);
demods2 = Am*fmdemod(s2t,fc,Fs,Am*kf2);

figure(5)
subplot(2,1,1)
plot(t,demods1);
hold on;
plot(t, mt);
title('Demodulated s1(t) and m(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s1(t)','m(t)');
subplot(2,1,2)
plot(t,demods2);
hold on;
plot(t, mt);
title('Demodulated s2(t) and m(t)');
ylabel('Amplitude');
xlabel('Time (s)');
legend('s2(t)','m(t)');