clc, clear all,close all;

Fs=3*10^3;
Ts=1/Fs;
t=0:Ts:(0.4-Ts);
N=4;
Tb=0.4/N;
s0=[zeros(1,Tb/(4*Ts)) ones(1,Tb/(4*Ts)) ones(1,Tb/(4*Ts)) zeros(1,Tb/(4*Ts))];
s1=[-1*ones(1,Tb/(3*Ts))  zeros(1,Tb/(3*Ts)) ones(1,Tb/(3*Ts)) ];

figure(1)
subplot(211);
plot(0:Ts:Tb-Ts,s0);
title("s0(t)");
ylabel("amplitude");
xlabel("time (s)");
subplot(212);
plot(0:Ts:Tb-Ts,s1);
title("s1(t)");
ylabel("amplitude");
xlabel("Time (s)")


%%

b = [1 0 1 0 ];


s= [];
for c=1:length(b)
    if (b(c)==0)
        s=[s s0];
    else
        s=[s s1];
    end
end

%% power
P=sum(abs(s).^2/length(s));

figure(2)
plot(t,s);
title("Transmitted signal s(t)");
ylabel("amplitude");
xlabel("time (s)");



snrdb1 = 15;
snrdb2 = 0;

snrlin1 = 10^(0.1*snrdb1);
snrlin2 = 10^(0.1*snrdb2);

var1 = P / snrlin1;
var2 = P / snrlin2;

n1=sqrt(var1)*randn(1,length(s));
n2=sqrt(var2)*randn(1,length(s));


r1 = s + n1;
r2 = s + n2;


figure(3)
plot(t,r1);
title("SNRdb = 15 r1")
ylabel("amplitude")
xlabel("time (s)")

figure(4)
plot(t,r2);
title("SNRdb = 0  r2")
ylabel("amplitude");
xlabel("time(s)")






%% 

Wb = Tb / Ts;




Wb=Tb/Ts;

r1_0=[];
r1_1=[];
r2_0=[];
r2_1=[];
for k=1:N
    sum1_0=0;
    sum1_1=0;
    sum2_0=0;
    sum2_1=0;
    for n=((k-1)*Wb+1):k*Wb
        sum1_0=sum1_0+r1(n).*s0((n-(k-1)*Wb));
        sum1_1=sum1_1+r1(n).*s1((n-(k-1)*Wb));
        sum2_0=sum2_0+r2(n).*s0((n-(k-1)*Wb));
        sum2_1=sum2_1+r2(n).*s1((n-(k-1)*Wb));
    end
    r1_0(k)=sum1_0;
    r1_1(k)=sum1_1;
    r2_0(k)=sum2_0;
    r2_1(k)=sum2_1;
end



bn=[1 2 3 4];
figure(5)
scatter(bn,r1_0)
hold on
scatter(bn,r1_1)
title("correlator output")
xlabel("b[n]")
ylabel("Correlation")
figure(6)
scatter(bn,r2_0)
hold on
scatter(bn,r2_1)
title("correlator output")
xlabel("b[n]")
ylabel("Correlation")




































