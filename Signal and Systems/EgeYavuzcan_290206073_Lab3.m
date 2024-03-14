
%%
Fs = 5000
T=4
t1 = (0:1/Fs:3)
t2 = (3:1/Fs:4)
fm = 1
x=0
b1 = (3 / (1/Fs)) + 1 
b2 = (1 / (1/Fs)) + 1 
X1 = t1.*ones(1,b1)
X2 = 3.*ones(1,b2)
figure(1)
plot(t1,X1)
figure(2)
plot(t2,X2)

t3 = (0:1/Fs:4)
b3 = (4 / (1/Fs)) + 1 
y1 = sin(2*pi*fm.*t3).*ones(1,b3)
figure(3)
plot(t3,y1)
t4 = (0:1/Fs:(4+1/Fs))
X4 = [X1,X2]
y2 = sin(2*pi*fm.*t4).*ones(1,b3+1)
Z = X4 + y2
figure(4)
plot(t4,X4)
figure(5)
subplot(3,1,1)
plot(t4,X4)
subplot(3,1,2)
plot(t3,y1)
subplot(3,1,3)

plot(t4,Z)

    
