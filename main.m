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

%% grafico da resposta controlada
syss_canonica = tf([0.2333/0.08333], [1/0.08333 1])

enter = input('Pressione Enter para continuar...')

%% ---------------------------------------------------------

Num = 2.8;   %% Numerador da F.T.
Den = 12;    %% Denominador da F.T. 
Mp = input("Entre com o valor do Overshoot em % ")
Ta = input("Entre com o tempo de acomodação em [s]")
Ess = 0;     %% Erro em Regime Permanente

%________________ Cálculo Ki_______________________
if (Ess ~=0) 
    Kv = 1/Ess;
    Ki = Kv/Num(1);
else
    Kv = 0
end


%__________________________________________

Mp1 = Mp/100; Mp2 = log(Mp1)/(-pi);
 
Qsi = sqrt((Mp2^2)/(1+Mp2^2)) % Cálculo de Qsi

MF = (asind(Qsi))*2;

Wn = 4/(Qsi*Ta); %Frequência Natural não amortecida
Wcg = i*Wn; %Frequência de Cruzamento de Ganho


G_jwcg = Num/((Den(1)*Wcg) + 1);

Mod_Gjwcg = abs(G_jwcg);

Anglo_Gjwcg = (angle(G_jwcg)*180)/pi;

Theta = -180 + MF - Anglo_Gjwcg;

if (Kv ~=0) 
    
    Kp = cosd(Theta)/ Mod_Gjwcg
    
    Kd = (Ki/Wn^2) + (sind(Theta)/(Mod_Gjwcg*Wn))

else
    
    Kp = cosd(Theta)/ Mod_Gjwcg

    Ki = -(sind(Theta)*Wn^2)/( Mod_Gjwcg * Wn);
    
    Kd = 0;
end

C_s = tf([Kd Kp Ki],[1 0]);
sys = tf(Num,Den)

D = series(C_s,sys);
E = feedback(D,1);

%% Aplicando o algoritmo para verificar a saáda do sistema em malha fechada com controlador PI
A1 = a1;
B1 = b1;
T = 0.1;

%Definindo pv como sendo a saída do sistema
pv(1)=0;

% Definindo cont como a saída do controlador PI
cont(1)=0;

%%Definindo a ação proporcional do sitsema
P(1)=0;

%%Definindo a açãointegral do sistema
I(1)=0;

%%Definindo o ganho proporcional do sistema
kp=Kp;

%%Definindo o ganho integral do sistema
ki=Ki;

m = M;
%%Implementando a malha fechada do sistema com controlador PI
%% Por meio da utilização da equacão da diferenças do sistema

for i=2:1:m+1
  pv(i)=A1*pv(i-1)+B1*cont(i-1); %% Saída instantanea do sistema
  erro(i)=sp - pv(i); %% Erro instataneo do sistema
  P(i)=kp*erro(i); %% ação proporcioanl
  I(i)=I(i-1)+ki*erro(i)*T; % ação Integral
  cont(i)=P(i)+I(i); %%ação do controlador PI saida
  t(i)=T*i; %%variável de tempo
end

%%Plotando os gráficos de entrada e saída do sistema
plot(t,pv,'r')
title("Resposta Controlada")



