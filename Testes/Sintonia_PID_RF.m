clc
clear all
close all
Num = input('Digite o vetor do Numerador da F.T.: ' ) 
Den = input('Digite o vetor do Denominador da F.T.: ' )
Mp = input('Digite o Valor do Máximo Pico em %: ' )
Ta = input('Digite o Valor do Tempo de Acomodação em [s]: ')
Ess = input('Digite o Valor do Erro em Regime Permanente para entrada rampa Unitaria: ')

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
step(E);
% figure
% margin(D)


