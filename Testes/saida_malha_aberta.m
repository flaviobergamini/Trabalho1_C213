%% Definindo as variaveis de entrada e saida
u=x1;%Degrau Aplicado
y=y1;%Resposta do Sistema de N�vel
t=T;%tempo 

%%Definindo o numero de amostras
x=size(u);
N=x(1);
M=N-1;

%% Definindo os tempos envolvidos
%%T=0.1; %Tempo de Amostragem
%%t=[0:T:M*T];

plot(t,y);
hold on;
plot(t, u);
