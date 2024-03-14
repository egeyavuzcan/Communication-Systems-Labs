clear all; clc; close all;
%%
b = [0 1 0 1 1];
bit_duration = 20e-3;
Fs = 10e3;
%sampling frequency 10e3
t = 0:1/Fs:(length(b)*bit_duration)-(1/Fs); 

%% 
reshaped_data = reshape(b, length(b), 1); 
sample_per_bit = bit_duration * Fs;
m = repmat(reshaped_data, 1, sample_per_bit);
m = reshape(m', 1, []); 
%information bit 0 represent 0V amplitude level 
% information bit 1 represent 5V
fc = 2.5e3;
carrier = cos(2*pi*fc.*t);
bask = m.*cos(2*pi*fc.*t);
bask = bask *5;
% figure;
% plot(t,bask)

%% noise
%use randi - 10db snr
%10db snr 10log10(P) power = 10
%randi([0 1],length(b))

%bask_noisy = bask + noise;
noisy = awgn(bask,10);



%% demodulation

Ith = 0.5; %for binary threshold value 
maximum_lag = 0;
demodulated_signal = zeros(1,length(b));

for i=1:length(b)
    noisy_signal = noisy((i-1)*sample_per_bit + (1:sample_per_bit));

    [correlation lags]= xcorr(noisy_signal,carrier(1:sample_per_bit),maximum_lag);
    
    demodulated_signal(i) = sum(abs(correlation));
end

l_th = max(demodulated_signal)/2; 
demod = zeros(1,length(b)); 

%%
for i = 1:length(b)
if demodulated_signal(i) > l_th 
    demod(i) = 1; 
else 
    demod(i) = 0; 
end
end

reshaped_demod = reshape(demod, length(demod), 1); 
demodulated_org_2 = repmat(reshaped_demod, 1, sample_per_bit); 
demodulated_last_2 = reshape(demodulated_org_2', 1, []); 




%% plotting
figure()
subplot(411);
plot(t,m)
xlabel("Time (s)")
ylabel("Amplitude)")
title("Message Signal ")
subplot(412);
plot(t,bask);
xlabel("Time (s)")
ylabel("Amplitude)")
title("BASK Signal ")
subplot(413);
plot(t,noisy);
xlabel("Time (s)")
ylabel("Amplitude)")
title("Noisy Bask Signal ")
subplot(414);
plot(t,demodulated_last_2)
xlabel("Time (s)")
ylabel("Amplitude)")
title("Demodulated Signal")

%% FSK

f0 = 0.5e3;
f1 = 0.75e3;

carrier0=cos(2*pi*f0*t);
carrier1=cos(2*pi*f1*t);


