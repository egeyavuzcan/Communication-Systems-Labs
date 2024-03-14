
fs = 10;
t1 = 0:1/fs:5;  %Time Matrices
t2 = 5+(1/fs):1/fs:15-(1/fs);
t3 = 15: 1/fs : 25;

x1 = 2 .* t1 - 5; %Function Matrices
x2 = 5 * cos(2*pi .* t2 );
x3 = 100 * exp((-1 .* t3) / 5 );

x = [x1,x2,x3]; %Matrix combining
t = [t1,t2,t3];

figure(1)
plot(t,x) %plotting
title (" x(t) signal time domain ")
xlabel (" Time (s) ")
ylabel (" Amplitude ")

%%

x_2 = cos(2*pi.*t*2); %second function
y1 = x .* x_2; %second output function
figure(2)
plot(t,y1);
title (" y1(t) signal time domain ");
xlabel (" Time (s) ")
ylabel (" Amplitude ")

%%
N = length(x) % number of DFT points
f = linspace(-fs/2,fs/2,length(x)) %frequency matrix creating by using sampling freq -fs/2 to fs/2 and using lenght of x
x_fft = fft(x,N) %fourier transforms
y_fft = fft(y1,N)
figure(3)
subplot(2,1,1)
plot(f,fftshift(abs(x_fft)/length(x_fft)),"Blue") %using fftshift and abs for absolute value
ylabel("| X(f) |")
xlabel(" Freq (s) ")
title("X(f) signal frequency domain")
subplot(2,1,2)
plot(f,fftshift(abs(y_fft)/length(y_fft)),"Red") 
xlabel("Freq (s)")
ylabel(" | Y(f) | ")
title("y(f) signal frequency domain")

%%
x_n = [x , zeros(1,length(x)-1)] %zero padding operation
x_2_n = [x_2 , zeros(1,length(x_2)-1)] %zero padding
f = linspace(-fs/2,fs/2,length(x_n)) %new freq matrix using length of x_n
Y2 = fft(x,length(x_n)) .* fft(x_2,length(x_2_n)) %obtain Y2 using multiplication of fourier transforms of functions

figure(4)

plot(f,fftshift(abs(Y2)/length(Y2))) %plotting
title(" |Y2(f)| frequency Domaimn")
xlabel("Frequency (Hz) ")
ylabel(" Y2(f) ")
%%

y2 = ifft(Y2,length(Y2)) %inverse fourier transform
%t2 =[0:0.1:50] %new time matrix 
t2 = linspace(0,50,length(Y2)) % using linspace for obtain new time matrix 
figure(5)
plot(t2,y2)
xlabel("Time (s)")
ylabel("Y2(t)")
title(" Y2(t) time domain")

%%

y2c = conv(x,x_2) %convolution 
figure (6)
subplot(2,1,1)

plot(t2,y2); %plottin y2 and y2c
xlabel("Time (s)");
ylabel("y2(t) ");
title("y2(t) signal in time domain");
subplot(2,1,2)
plot(t2,y2c,"blue");
xlabel(" Time");
ylabel("y2c(t) ");
title("y2c(t) signal in time domain");