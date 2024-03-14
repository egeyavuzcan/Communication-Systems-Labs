clear all; clc; close all;
%% parameters
fs = 27000;
rb = 18000;
M=4;
N = 1000;
symbols = 1000;
signal_random = randi([0,(M-1)],1,N);

%% pam signal
signal_pam = zeros(1,N);
for i = 1:length(signal_random)
    if signal_random(i) == 0
        signal_pam(i) = 1;
    elseif signal_random(i) == 1
        signal_pam(i) = 3;
    elseif signal_random(i) == 2
        signal_pam(i) = -1;
    else 
        signal_pam(i) = -3;
    end
end 

figure(1)
plot(signal_pam)
%%
rs = rb / log2(M);
sps = fs / rs;

%%

rolloff_factor1 = 0;
rolloff_factor2 = 0.5;
rolloff_factor3 = 1;

span = 10; %truncrate filter symbol

h_roll0=rcosdesign(rolloff_factor1, span,sps,'sqrt');

h_roll1=rcosdesign(rolloff_factor2,span,sps ,'sqrt');

h_roll2=rcosdesign(rolloff_factor3 ,span,sps,'sqrt');

%%

fft_h0 = abs(fftshift((fft(h_roll0,length(h_roll0)))/length(h_roll0)));

fft_h1 = abs(fftshift((fft(h_roll1,length(h_roll1)))/length(h_roll1)));

fft_h2 = abs(fftshift((fft(h_roll2,length(h_roll2)))/length(h_roll2)));

f1=linspace(-fs/2,fs/2,length(h_roll0));
f2 = linspace(-fs/2,fs/2,length(h_roll1));
f3 = linspace(-fs/2,fs/2,length(h_roll2));


figure(2);
subplot(2,3,1)
plot(h_roll0); 
title('signal roll of=0.0'); 
xlabel('time(s)'); 
ylabel('Amplitude');
subplot(2,3,2)
plot(h_roll1); 
title('signal roll-off=0.5'); 
xlabel('time(s)'); 
ylabel('Amplitude');
subplot(2,3,3)
plot(h_roll2); 
title('signal roll-off=1'); 
xlabel('time(s)'); 
ylabel('Amplitude');

subplot(2,3,4)
plot(f1,(fft_h0)); 
title('frequency domain roll of= 0.0'); 
xlabel('frequency'); 
ylabel(' Amplitude');
subplot(2,3,5)
plot(f2,(fft_h1)); 
title('frequency domain roll of= 0.5'); 
xlabel('frequency'); 
ylabel(' Magnitude');
subplot(2,3,6)
plot(f3,(fft_h2)); 
title('frequency domain roll of = 1.0'); 
xlabel('frequency'); 
ylabel(' Öagnitude');

%% transmitted signal 

transmitted_h0 = upfirdn(signal_pam,h_roll0,sps,1); % sps,1 for upsample
transmitted_h1 = upfirdn(signal_pam,h_roll1,sps,1);
transmitted_h2 = upfirdn(signal_pam,h_roll2,sps,1);

%% coefficents
b = 1;
a = 1;

%% filtering 

transmitted_h0_filtered = filter(b,a,transmitted_h0);
transmitted_h1_filtered = filter(b,a,transmitted_h1);
transmitted_h2_filtered = filter(b,a,transmitted_h0);

%% awgn part
SNR= 20;
received_h0 = awgn(transmitted_h0_filtered,SNR);
received_h1 = awgn(transmitted_h1_filtered,SNR);
received_h2 = awgn(transmitted_h2_filtered,SNR);

%% filter and downsample 
yout0 = upfirdn(received_h0,h_roll0,1,sps);
yout1 = upfirdn(received_h1,h_roll1,1,sps); % 1,sps for downsample
yout2 = upfirdn(received_h2,h_roll1,1,sps);

%% remove 

yout0 = yout0(1+1:end-1);
yout1 = yout1(1+1:end-1);
yout2 = yout2(1+1:end-1);

%% eye diagram 
eyediagram(yout0,sps,1/fs,0); title(' eye diagram roll-off = 0');
eyediagram(yout1,sps,1/fs,0); title('eye diagram roll-off = 0.5');
eyediagram(yout2,sps,1/fs,0); title('eye diagram roll-off =  1');

%% 
W = 6000;
rates = [25 33 50 67 75 100];
rolls = [ rolloff_factor1 rolloff_factor2 rolloff_factor3];
for j = 1:length(rolls)
    for i = 1:length(rates)
        symbol_rates(i) = W+(W*log2(M)) / (1 + (W*rates(i)/100 ));
    end
end
figure(6)
plot(rates,symbol_rates)

for i = 1:length(rates)
    excess_bw(i) = (1 + (rolloff_factor2 * (2*rates(i))))+ W
end


for i = 1:length(rates)
    excess_bw(i) = (1 + (rolloff_factor3 * (2*rates(i))))+ W
end
