% Definición del rango de valores de Eb/N0 en dB, de 1 a 11
EbN0_dB = linspace(1, 11, 11);
EbN0_linear = 10 .^ (EbN0_dB / 10);

% Cálculo de BER para BPSK
BER_BPSK = 0.5 * erfc(sqrt(EbN0_linear));

% Cálculo de BER para QPSK
BER_QPSK = 0.5 * erfc(sqrt(EbN0_linear / 2));

% Cálculo de BER para 8PSK
M_8PSK = 8; % Número de símbolos en 8PSK
k_8PSK = log2(M_8PSK);
BER_8PSK = 2 * (1 / k_8PSK) * erfc(sqrt((3 / (M_8PSK - 1)) * k_8PSK * EbN0_linear));

% Generación de la gráfica
figure;
semilogy(EbN0_dB, BER_BPSK, 'b^-', 'LineWidth', 1.5, 'MarkerSize', 6); hold on;
semilogy(EbN0_dB, BER_QPSK, 'r*-', 'LineWidth', 1.5, 'MarkerSize', 6);
semilogy(EbN0_dB, BER_8PSK, 'g+-', 'LineWidth', 1.5, 'MarkerSize', 6);
hold off;

% Configuración del gráfico
grid on;
title('Relación BER vs. Eb/N0 para BPSK, QPSK y 8PSK');
xlabel('Eb/N0 (dB)');
ylabel('BER');
legend('BPSK', 'QPSK', '8PSK');
set(gca, 'YScale', 'log', 'FontSize', 12);
