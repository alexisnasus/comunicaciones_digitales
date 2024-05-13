num_bits = 10000; %bits
alpha_values = [0, 0.25, 0.75, 1]; %rollof
span = 10; % número de periodos de símbolo en los filtros
sps_values = [10, 4]; % muestras por símbolo (samples per symbol)
bits_sequence = randi([0 1], num_bits, 1);

for sps = sps_values
    for alpha = alpha_values
        %NRZ-L
        encoded_data = (2 * bits_sequence) - 1;
        % Filtro de pulso coseno alzado
        filtro_cos_alzado = rcosdesign(alpha, span, sps, 'normal');
        % modulación
        senal_tx = upfirdn(encoded_data, filtro_cos_alzado, sps);

        % Agregar ruido gaussiano blanco
        snr = 20; % Relación señal a ruido en dB
        senal_rx = awgn(senal_tx, snr, 'measured');

        % Crear el diagrama de ojo
        eye_diagram = eyediagram(senal_rx, 2 * sps);
        
        % Configurar propiedades del diagrama
        set(eye_diagram, 'Visible', 'On', 'Name', ['Diagrama de ojo: Roll-off = ' num2str(alpha) ', sps = ' num2str(sps)]);
        
        % Activar cuadrícula en el diagrama
        grid on;
    end
end
