fc = 1000; %frec de la portadora
fs = 10000; %fre de muestreo
t = 0:1/fs:1-1/fs; %vector tiempo

m = square(2*pi*100*t); %señal cuadrada
g=m;

G=fftshift(fft(g)); %transformada de fourier de envolvente compleja
f = (-fs/2:fs/2-1)/fs * fs;
figure;
plot(f, abs(G)/length(G));
title('Transformada de fourier de la envolvente compleja g(t) para ASK');
xlabel('Frecuencia en Hz');
ylabel('Magnitud');
grid on;