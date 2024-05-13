%Parametros
B = 1; % Ancho de banda
f = linspace(-2*B, 2*B, 1000); %Vector Frecuencia
t = linspace(0, 2.5, 1000); %Vector de tiempos
alpha_values = [0, 0.5, 0.75, 1];
figure;
subplot(1, 1, 1);
hold on;
for alpha = alpha_values
    hc = (sin(pi*t*(1-alpha)) + 4*alpha*t.*cos(pi*t*(1+alpha))) ./(pi*t.*(1-(4*alpha*t).^2));
    hc(t==0) = 1 - alpha;
    plot(t, hc);
end
title('Respuesta a Impulso del Pulso Coseno Alzado');
xlabel('t');
ylabel('hc(t)');
legend(strcat('\alpha = ', string(alpha_values)), 'Location','best');
hold off;

