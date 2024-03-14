Fs = 2000;
f1 = 60;
f2= 90;
Ts = 1/Fs;
time = 0:Ts:(0.05-Ts);

n = length(time);
mt = 0.8 * cos(2*pi*f1.*time) + 0.7*sin(2*pi*f2.*time);

for i = 1:(n-1) 
    m_der(i) = (mt(i+1) - mt(i))/Ts;
end

delta = Ts * ( max(m_der));
mq = zeros(1,n);
err = zeros(1,n);
errq = zeros(1,n);
mq(1) = 0;
for i = 2:n
    err(i) = mt(i) - mq(i-1);
    errq(i) = sign(err(i));
    mq(i) = mq(i-1) + errq(i);
    
    
    if (mt(i) >= mq(i))
        mq(i) = mq(i) + delta;
        err(i) =1;
    else
        mq(i) = mq(i) -delta;
        err(i)= -1;
    
    end
 
end 

en_out = zeros(1,n);
for i = 1:n
    
    if (err(i)==1)
        en_out(i) = 1;
    else
        en_out(i) = 0;
    end 
end
        

figure(1)
plot(time, mt);
hold on;
stairs(time, mq);



















%%

encode_size = length(en_out);
mq(1)=0;


for j=2:encode_size
    if (en_out(j) == 0)
        mq(j)= mq(j) -delta;
    else
        mq(j)= mq(j) +delta
    end
end
cf= 0.1;
n = 100;
b = fir1(100,cf);
out=conv2(length(en_out),b,"same");

figure(2)
plot(time, out);
hold on;
plot(time,mq);







%%
figure(3)
subplot(211)
plot(time,mt)
hold on
plot(time,mq)
subplot(212)
plot(time,mt)
hold on
plot(time,out)


