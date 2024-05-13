% Parámetros
B = 1; % Ancho de banda
f = linspace(-2*B, 2*B, 1000); % Vector Frecuencia
t = linspace(0, 2.5, 1000); % Vector de tiempos
alpha_values = [0, 0.25, 0.75, 1];

% Respuesta al impulso
figure;
subplot(2, 1, 1);
hold on;
for alpha = alpha_values
    hc = (sin(pi*t*(1-alpha)) + 4*alpha*t.*cos(pi*t*(1+alpha))) ./(pi*t.*(1-(4*alpha*t).^2));
    hc(t==0) = 1 - alpha;
    plot(t, hc);
end
title('Respuesta al Impulso del Pulso Coseno Alzado');
xlabel('t');
ylabel('hc(t)');
legend(strcat('\alpha = ', string(alpha_values)), 'Location','best');
hold off;

% Respuesta en frecuencia
subplot(2, 1, 2);
hold on;
for alpha = alpha_values
    He = raised_cosine_transfer_function(f, B, alpha); % Calcular función de transferencia
    plot(f, abs(He));
end
title('Respuesta en Frecuencia del Pulso Coseno Alzado');
xlabel('f');
ylabel('|He(f)|');
legend(strcat('\alpha = ', string(alpha_values)), 'Location','best');
hold off;

% Función de transferencia del filtro de coseno alzado de Nyquist
function He = raised_cosine_transfer_function(f, B, alpha)
    f0 = B / (1 + alpha); % Ancho de banda de 6 dB del filtro
    f_delta = B - f0; % Diferencia entre el ancho de banda absoluto y el ancho de banda de 6 dB
    f1 = f0 - f_delta; % Frecuencia de corte
    
    He = ones(size(f)); % Inicializar la función de transferencia
    
    % Definir la función de transferencia según las condiciones dadas
    He(abs(f) < f1) = 1;
    He(abs(f) >= f1 & abs(f) < B) = 0.5 * (1 + cos(pi * (abs(f(abs(f) >= f1 & abs(f) < B)) - f1) / (2 * f_delta)));
    He(abs(f) >= B) = 0;
end
