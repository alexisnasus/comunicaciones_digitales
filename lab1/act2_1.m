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
d_nat = tau/t_s;    % ciclo de trabajo para muestreo natural
d_inst = tau/tm;    % ciclo de trabajo para muestreo instantáneo

% Vectores
t = (0:ls-1)*tm;
m_t = sin(2*pi*f_c*t);

% Auxiliares
r = floor(t_s/tm);
s = floor(tau/tm);

% Muestreo natural
s_nat = zeros(1,length(t));
for i=1:length(m_t)
    if mod(i,r)==0
        s_nat(i:i+s) = 1;
    end
end
s_nat = s_nat(1:length(t));
m_t_nat = m_t.*s_nat;

% Muestreo instantáneo
m_t_inst = zeros(1,length(t));
for i=1:length(m_t)
    if mod(i,r)==0
        m_t_inst(i:i+s) = m_t(i);
    end
end
m_t_inst = m_t_inst(1:length(t));

% Gráficas en subplots
figure;

subplot(3,1,1);
plot(t,m_t); % Señal original
grid on;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal Original');

subplot(3,1,2);
plot(t,m_t_nat,'-r'); % Señal muestreada de forma natural
grid on;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Muestreo Natural');

subplot(3,1,3);
plot(t,m_t_inst); % Señal muestreada de forma instantánea
grid on;
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Muestreo Instantáneo');