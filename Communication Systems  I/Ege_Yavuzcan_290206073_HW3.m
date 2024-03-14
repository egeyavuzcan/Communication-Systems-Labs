fs = 2000;
t = 0:1/fs:0.2;
fc=200;
Ac=1;
%signals
c = Ac*cos(2*pi*fc*t);
message1 = cos(2*pi*50*t);
message2 = cos(2*pi*10*t);
%phases
kp=pi/4;
phase1 = kp*message1;
phase2 = kp*message2;
%modulates signals
s1=Ac*cos((2*pi*fc*t)+phase1);
s2=Ac*cos((2*pi*fc*t)+phase2);
%construct s3
message3=message1+message2;
phase3=kp*message3;
s3=Ac*cos((2*pi*fc*t)+phase3);
%construct ( s1+s2)
sum=s1+s2;
figure (1)
subplot(2,1,1)
plot(t,s3);
xlabel(" Time(s) ");
ylabel(" Amplitude ");
title(" s3(t) Normal ");
subplot(2,1,2)
plot(t,sum);
xlabel(" Time(s) ");
ylabel(" Amplitude ");
title(" (s1(t)+s2(t))");

%% effect kp value
kp2=2*pi/4;
kp3=3*pi/4;

phase3=kp2*message1;
Spm1=Ac*cos((2*pi*fc*t)+phase3);

phase4=kp3*message1;
Spm2=Ac*cos((2*pi*fc*t)+phase4);

figure (2)
subplot(4,1,1)
plot(t,message1,"blue");
xlabel(" Time(s) ");
ylabel(" Amplitude ");
title(" m1(t) Message signal ");

subplot(4,1,2)
plot(t,s1,'red');
xlabel(" Time(s) ");
ylabel(" Amplitude ");
title(" s1(t) Modulated signall ");

subplot(4,1,3)
plot(t,Spm1,"black");
xlabel(" Time(s) ");
ylabel(" Amplitude ");
title(" Spm1(t) using kp = 2*pi/4");

subplot(4,1,4)
plot(t,Spm2,'green');
xlabel(" Time(s) ");
ylabel(" Amplitude ");
title(" Spm2(t) using kp = 3*pi/4 ");

%% demodulating

%demodulate spm ,spm1,spm2
% fist hilbert transform, second obtain angle and construct demod signal
Spm_hilbert=hilbert(s1,length(t));
Phase1=angle(Spm_hilbert);
uwrap1=unwrap(Phase1);
demod_Spm=(uwrap1-2*pi*fc*t)/kp;

Spm1_hilbert=hilbert(Spm1,length(t));
Phase2=angle(Spm1_hilbert);
uwrap2=unwrap(Phase2);
demod_Spm1=(uwrap2-2*pi*fc*t)/kp2;

Spm2_hilbert=hilbert(Spm2,length(t));
Phase3=angle(Spm2_hilbert);
uwrap3=unwrap(Phase3);
demod_Spm2=(uwrap3-2*pi*fc*t)/kp3;

figure (3)
subplot(3,1,1)
plot(t,message1);
hold on
plot(t,demod_Spm);
xlabel(" Time(s) ");
ylabel(" Amplitude ");
title("message m1(t) and demodulated signal s1(t)");
legend("m1(t)","s1(t)");

subplot(3,1,2)
plot(t,message1);
hold on
plot(t,demod_Spm1);
xlabel(" Time(s) ");
ylabel(" Amplitude ");
title("message m1(t) and demodulated signal Spm1(t)");
legend("m1(t)","Spm1(t)");

subplot(3,1,3)
plot(t,message1);
hold on
plot(t,demod_Spm2);
xlabel(" Time(s) ");
ylabel(" Amplitude ");
title("message m1(t) and demodulated signal Spm2(t)");
legend("m1(t)","Spm2(t)");