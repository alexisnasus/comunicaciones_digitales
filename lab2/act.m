clear;

% Parámetros
N = 10000; % Número de bits
alpha_values = [0, 0.25, 0.75, 1]; % Diferentes valores de roll-off
span = 10; % Número de periodos de símbolo en los filtros
sps = 8; % Muestras por símbolo

% Generar bits aleatorios
data = randi([0 1], N, 1);

% Codificación NRZ-L
data_nrz = (2 * data) - 1;

for alpha = alpha_values
    % Filtro de pulso coseno alzado para el roll-off actual
    h = rcosdesign(alpha, span, sps, 'normal');

    % Modulación con filtro de coseno alzado
    txSig = upfirdn(data_nrz, h, sps);

    % Añadir ruido gaussiano blanco
    snr = 20; % Relación señal a ruido en dB
    rxSig = awgn(txSig, snr, 'measured');

    % Crear la figura del diagrama de ojo
    fig = eyediagram(rxSig, 2 * sps);
    
    % Ajustar las propiedades de la figura
    set(fig,'Visible','On','Name',['Diagrama de ojo con roll-off = ' num2str(alpha)]);
    
    % Activar la cuadrícula en la figura
    grid on;
end
