%%
freq1 = 1 * 10.^6
freq2 = 1 * 10.^6
freq3 = 50 * 10.^3
freq4 = 50 * 10.^3
w1 = 2*pi*freq1
w2 = 2*pi*freq2
w3 = 2*pi*freq3
w4 = 2*pi*freq4
R = 3 * 10.^5
Q1 =  1000
Q2 =  100
Q3 =  1000
Q4 =  100
Ts = 1 * 10.^-7
t = linspace(0,2*10.^-3,2*10.^-3 / Ts)
figure(1)
g1 = ((w1 * R ) / Q1) * exp((-w1 * t)/(2*Q1)).*cos(w1 * t)
max1 = max(g1)
g1 = g1 / max1
plot(t,g1)
figure(2)
g2 = ((w2 * R ) / Q2) * exp(-w2*t/(2*Q2)).*cos(w2*t)
max2 = max(g2)
g2 = g2 / max2
plot(t,g2)
figure(3)
g3 = ((w3 * R ) / Q3) * exp(-w3*t/(2*Q3)).*cos(w3*t)
max3 = max(g3)
g3 = g3 / max3
plot(t,g3)
figure(4)
g4 = ((w4 * R ) / Q4) * exp(-w4*t/(2*Q4)).*cos(w4*t)
max4 = max(g4)
g4 = g4 / max4
plot(t,g4)
sigma1 = 5 * 10.^-4
sigma2 = 2 * 10.^-4
sigma3 = 2 * 10.^-8
u = 0
figure(5)
lambda1 = exp((-(t-u).^2)/(2*(sigma1 .^2)))
plot(t,lambda1)
figure(6)
lambda2 = exp((-(t-u).^2)/(2*(sigma2 .^2)))
plot(t,lambda2);
figure(7);
lambda3 = exp((-(t-u).^2)/(2*(sigma3 .^2)));
plot(t,lambda3);

%%
g5 = ((w1 * R ) / 500) * exp(-w1*t/(2*500)).*cos(w4*t)
lambda4 = exp((-(t-0).^2)/(2*(sigma2 .^2)))
figure(8)
plot(t,g5)
figure(9)
plot(t,lambda4)
y1 = 0
for t=0:2*10.^-3:Ts
    y1 = y1 + (g5 .* lambda4)
end
figure(10)
t = linspace(0,2*10.^-3,2*10.^-3 / Ts)
y1 = y1 / max(y1)
plot(t,y1)
y2 = 0
lambda5 = exp((-(t-(5*10.^-4)).^2)/(2*(sigma2 .^2)))
for t=0:2*10.^-3:Ts
    y2 = y2 + (g5 .* lambda5)
end
konvol1 = conv(g5,lambda4)
figure(14)
plot(konvol1)
t = linspace(0,2*10.^-3,2*10.^-3 / Ts)
figure(11)
plot(t,g5)
figure(12)
plot(t,lambda5)
figure(13)
y2 = y2 / max(y2)
plot(t,y2)
konvol2 = conv(g5,lambda5)
figure(15)
konvol2 = konvol2 / max(konvol2)
plot(konvol2)
