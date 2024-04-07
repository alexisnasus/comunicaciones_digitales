clc;
close all;
clear all;

% Parámetros de configuración
fm = 100000; % Hz
tm = 1/fm;  % segundos
ls = 200;  % largo de la señal
f_c = 1000; % Hz
f_s = 5000; % Hz
t_s = 1/f_s;    % segundos
tau = 0.5*t_s;  % segundos

% Vectores
t = (0:ls-1)*tm;
m_t = sin(2*pi*f_c*t);

% Auxiliares
r = floor(t_s/tm);
s = floor(tau/tm);

% Muestreo instantáneo
m_t_inst = zeros(1,length(t));
for i=1:length(m_t)
    if mod(i,r)==0
        m_t_inst(i:i+s) = m_t(i);
    end
end
m_t_inst = m_t_inst(1:length(t));

% Parámetros PCM
N = 2; % Número de bits para PCM
pcm_levels = 2^N; % Total de niveles PCM

% Cuantizar la señal instantánea usando PCM
pcm_signal_inst = round((m_t_inst + 1) * (pcm_levels - 1) / 2); % Cuantización

% Normalizar las señales para que estén en el mismo rango de amplitud (0 a 1)
m_t_norm = (m_t - min(m_t)) / (max(m_t) - min(m_t));
m_t_inst_norm = (m_t_inst - min(m_t_inst)) / (max(m_t_inst) - min(m_t_inst));
pcm_signal_inst_norm = (pcm_signal_inst - min(pcm_signal_inst)) / (max(pcm_signal_inst) - min(pcm_signal_inst));

% Calcular el error de cuantización para la señal PAM cuantificada (PCM)
quantization_error_inst = m_t_inst - ((2 * pcm_signal_inst / (pcm_levels - 1)) - 1);

% Crear una figura para mostrar todas las señales en un mismo gráfico
figure;

% Graficar la señal original en azul
plot(t, m_t_norm, 'b', 'LineWidth', 1.5);
hold on;

% Graficar la señal PAM instantánea en rojo
plot(t, m_t_inst_norm, 'r', 'LineWidth', 1.5);

% Graficar la señal PAM cuantificada (PCM) en verde (usar marcador 'o' para visualizar los puntos PCM)
stem(t, pcm_signal_inst_norm, 'g', 'Marker', 'o', 'LineWidth', 1.5);

% Establecer etiquetas y título del gráfico
xlabel('Tiempo (s)');
ylabel('Amplitud Normalizada');
title('Señal Original, Señal PAM Instantánea y Señal PAM Cuantificada (PCM)');
legend('Señal Original', 'Señal PAM Instantánea', 'Señal PAM Cuantificada (PCM)');
grid on;

% Crear una nueva figura para mostrar el error de cuantización
figure;

% Graficar el error de cuantización para la señal PAM cuantificada (PCM)
plot(t, quantization_error_inst, 'k--', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Error de Cuantización');
title('Error de Cuantización para la Señal PAM Cuantificada (PCM)');
grid on;
