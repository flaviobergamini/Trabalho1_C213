%% Definindo as variaveis de entrada e saida
u=x1;%Degrau Aplicado
y=y1;%Resposta do Sistema de Nível
t=T; %tempo

%%Definindo o numero de amostras
x=size(u);
N=x(1);
M=N-1;

%% Definindo os tempos envolvidos
TA=0.1; %Tempo de Amostragem

%%Criando a Matriz F e vetor Y
F=[y(1:M,1) u(1:M,1)];
Y=[y(2:N,1)];

%%Calculando os coeficientes a1 e b1

theta=inv(F'*F)*F'*Y;
a1=theta(1,1);
b1=theta(2,1);

%%Calculando a função em Z

sysz=tf([b1],[1 -a1],TA);

%%Calculando a função em S

syss=d2c(sysz);

%% gráfico de mínimos quadrados
ye = step(u(1)*syss,t);

%% plot(t,ye,t,y1)

%% definindo set point
sp = 30;

%% gráfico em malha aberta
malha_aberta = step(syss*sp);
plot(malha_aberta)
title("Malha Aberta")

enter = input('Pressione Enter para ver o grafico de Malha Fechada')

%% gráfico em malha fechada
malha_fechada = feedback(syss,1);

plot(step(malha_fechada*30))
title("Malha Fechada")
