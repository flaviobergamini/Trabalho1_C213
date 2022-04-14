%% Aplicando o algoritmo para verificar a sa�da do sistema em malha fechada com controlador PI
a1 = 0.9955;
b1 = 0.0067;
T = 0.1;

%Definindo pv como sendo a sa�da do sistema
pv(1)=0;

% Definindo cont como a sa�da do controlador PI
cont(1)=0;

%%Definindo a a��o proporcional do sitema
P(1)=0;

%%Definindo a a��o integral do sistema
I(1)=0;
sp=50;

%%Definindo o ganho proporcional do sistema
Kp=0.5337;

%%Definindo o ganho integral do sistema
Ki=0.0673;

M = 1500;
%%Implementando a malha fechada do sistema com controlador PI
%% Por meio da utiliza��o da equa��o a diferen�as do sistema

for i=2:1:M+1
  pv(i)=a1*pv(i-1)+b1*cont(i-1); %% Sa�da instantanea do sistema
  erro(i)=sp - pv(i); %% Erro instataneo do sistema
  P(i)=Kp*erro(i); %% A��o proporcioanl
  I(i)=I(i-1)+Ki*erro(i)*T; %A��o Integral
  cont(i)=P(i)+I(i); %%A��o do controlador PI saida
  t(i)=T*i; %%vari�vel de tempo
end

%%Plotando os gr�ficos de entrada e sa�da do sistema
plot(t,pv,'r')
hold on
plot(t,sp,'b')
grid on