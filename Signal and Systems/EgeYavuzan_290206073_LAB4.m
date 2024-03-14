%%
dt = 0.001
t = 0:dt:10
t1 = 0:dt:5
t2 = 5.001:dt:10
T = 10
f = 0.2
teta = 6*dt
%%
x1 = -exp(-1.*t1)
x2 = -1*sin((2*pi*f.*t2)+teta)
figure(1)
subplot(2,1,1)
plot(t1,x1)
subplot(2,1,2)
plot(t2,x2)
%%
x3 = [x1,x2]
figure(2)
plot(t,x3)
xlabel("Time")
ylabel("Values")


hold on
%%
xsignal1 = -exp(-1.*(t1+1)) - (-exp(-1.*t1))
xsignal2 = -1*sin((2*pi*f.*(t2+1))+teta) - (-1*sin((2*pi*f.*t2)+teta))
xsignal = [xsignal1,xsignal2]
xsignal(1)=1
figure(2)
plot(t,xsignal)
legend("Xintegral","xsignal")
%%
k = -3000:1:3000

for i=1:length(k)
    ak(i)= (1/T) * (sum (xsignal .* exp(-1i*k(i)*2*pi/T.*t) .*dt));
end
%%
N1=50
xust = ones(1,100)
for i=1:length(100)
    xust(i) = sum(ak .* exp(-1i*k(i)*2*pi/T.*t) )
end
%%
figure(4)




