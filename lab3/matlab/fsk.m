fc = 1000; %frec de la portadora
f1 = 900; %frec simbolo 0
f2 = 1100; %frec simbolo 1
fs = 10000;
t = 0:1/fs:1-1/fs; %vector tiempo

data = randi([0 1], 1, length(t));

m = cos(2*pi*f1*t) .* (data == 0) + cos(2*pi*f2*t) .* (data == 1) ;

g = exp(1j*2*pi*f1*t) .* (data == 0) + exp(1j*2*pi*f2*t) .* (data == 1) ;

G = fftshift(fft(g)); 

f = (-fs/2:fs/2-1)/fs * fs;

figure;
plot(f, abs(G)/length(G));
title('Transformada de fourier de la envolvente compleja g(t) para FSK');
xlabel('Frecuencia en Hz');
ylabel('Magnitud');
grid on;