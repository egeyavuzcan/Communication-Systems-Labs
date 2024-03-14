t = linspace(0,1,1000);
x1 = -exp(-4*t);
x2 = cos(2*pi*t);
alfa = 2;
beta = 3;
y1 = power(x1,2);
y2 = power(x2,2);
x3 = alfa*x1 + beta*x2;
y3 = power(x3,2);
y4 = alfa*y1 + beta*y2;
if y4 == y3
    disp("H is a linear system");
else
    disp("H is a non-linear system")
end
figure(1)
plot(t,x1,t,x2)
legend("x1","x2")
xlabel("Time")
ylabel("Position")
figure(2)
subplot(2,1,1)
plot(t,y3)
xlabel("Time")
ylabel("Position")
legend("y3")
subplot(2,1,2)
plot(t,y4)
legend("y4")
xlabel("Time")
ylabel("Position")
