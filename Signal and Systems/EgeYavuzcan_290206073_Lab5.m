f1 = 5
f2 = 300
dt = 0.001
t= 0:0.001:1
x = (-2 * sin(pi*f2.*t).^2 + 2 *sin(pi*f1.*t).*cos(pi*f1.*t))+1 ;
figure(1);
plot(t,x);
xlabel("Time")
ylabel("X(t)")
legend("x(t)")
%%


f = -500:1:500
t = 0:0.001:1
xf = zeros(1,length(f));
for j=1:length(f)
    xf(j) = sum(x.* exp(-1i * 2 * pi * f(j) .* t) *dt);
end

figure(2)
plot(f,xf)
xlabel("Frequency")
ylabel("X(f)")



%%

xfft = fft(x,1000)
xfft = fftshift(xfft)
xfft= abs(xfft)/1000;
fs = linspace(-500,500,1000);
figure(3)
plot(fs,abs(xfft))



xf= abs(xf);
figure(4)
plot(f,abs(xf))
title("Manual")
hold on
figure(5)
plot(fs,abs(Xfft))
title('fft')
hold on 
