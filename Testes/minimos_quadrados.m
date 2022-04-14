%% Definindo as variaveis de entrada e saida
u=x1;%Degrau Aplicado
y=y1;%Resposta do Sistema de Nível

%%Definindo o numero de amostras
x=size(u);
N=x(1);
M=N-1;

%% Definindo os tempos envolvidos
T=0.1; %Tempo de Amostragem
t=[0:T:M*T];

%%Criando a Matriz F e vetor Y
F=[y(1:M,1) u(1:M,1)];
Y=[y(2:N,1)];

%%Calculando os coeficientes a1 e b1

theta=inv(F'*F)*F'*Y;
a1=theta(1,1);
b1=theta(2,1);

%%Calculando a função em Z

sysz=tf([b1],[1 -a1],T);

%%Calculando a função em S

syss=d2c(sysz);


ye = step(u(1)*syss,t);

plot(t,ye,t,y1)


