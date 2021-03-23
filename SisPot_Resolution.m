% formato longo
format long

% ------- defasadores (mais 30 e menos 30)

def_mais = (0.866025403785 + i*0.5);
def_menos = (0.866025403785 - i*0.5);

% ------- escolher valores de bases (para s e v)

sb = 100000000;
vb1 = 13800;
vb2 = 230000;
vb6 = vb1;
vb4 = vb1;
vb8 = 14500;
vb12 = vb8;
vb10 = vb8;

zb1 = (vb1^2)/sb;
zb2 = (vb2^2)/sb;
zb4 = (vb4^2)/sb;
zb8 = (vb8^2)/sb;
zb10 = (vb10^2)/sb;
zb12 = (vb12^2)/sb;
zb6 = (vb6^2)/sb;


%------------------------ escolher infos para os trafos (sb=100M e zcc's)


zccT12 = (0.01 + i*0.1)*(10/8);
zccT34 = (0.01 + i*0.1)*(10/5);
zccT56 = (0.01 + i*0.1)*(10/7);
zccT78 = (0.008 + i*0.08);
zccT910 = (0.008 + i*0.08)*(10/5);
zccT1112 = (0.008 + i*0.08)*(10/5);

%------------------------ escolher infos para os trafos (sb=100M e zat's)

zat12 = 0.5*(10/8);
z0_T12 = (3*zat12 + zccT12);


%------------------------ escolher infos para as linhas (tamanho e impedancia)

zL0_23 = 80*(0.483 + i*1.373)/zb2;
zL0_25 = 96*(0.483 + i*1.373)/zb2;
zL0_27 = 48*(0.483 + i*1.373)/zb2;
zL0_39 = 32*(0.483 + i*1.373)/ zb2;
zL0_511 = 24*(0.483 + i*1.373)/zb2;
zL1_23 = 80*(0.066+ i*0.375)/zb2;
zL1_25 = 96*(0.066+ i*0.375)/zb2;
zL1_27 = 48*(0.066+ i*0.375)/zb2;
zL1_39 = 32*(0.066+ i*0.375)/ zb2;
zL1_511 = 24*(0.066+ i*0.375)/zb2;
zL2_23 = zL1_23;
zL2_25 = zL1_25;
zL2_27 = zL1_27;
zL2_39 = zL1_39;
zL2_511 = zL1_511;


%------------------------ escolher infos para as cargas (8, 10, 12)

z0_c12 = [30 + (3.89 +i*1.66)]/zb12;
z1_c12 = (3.89 +i*1.66)/zb12;
z2_c12 = z1_c12;
z0_c8 = (2.19 + i*0.93)/zb8;
z1_c8 = z0_c8;
z2_c8 = z0_c8;
z0_c10 = [(13.14+i*5.6)/3]/zb10;
z1_c10 = z0_c10;
z2_c10 = z1_c10;

%------------------------ escolher infos para as cargas 1, 4 e 6 (via potencia de cc)

Zsempu_c1 = (13.8^2)/(66-i*660);
Z0sempu_c1 = ((3*((13.8^2)/(44-i*440)))-Zsempu_c1);
z0_c1 = Z0sempu_c1/zb1;
z1_c1 = Zsempu_c1/zb1;
z2_c1 = z1_c1;
v1_thc1 = 1;


Zsempu_c4 = (13.8^2)/(59.4-i*594);
Z0sempu_c4 = ((3*((13.8^2)/(39.6-i*396)))-Zsempu_c4);
z0_c4 = Z0sempu_c4/zb4;
z1_c4 = Zsempu_c4/zb4;
z2_c4 = z1_c4;
v1_thc4 = 1.01007343012 - i*0.141956562979; %converti pra retangular



Zsempu_c6 = (13.8^2)/(59.4-i*594);
Z0sempu_c6 = ((3*((13.8^2)/(39.6-i*396)))-Zsempu_c6);
z0_c6 = Z0sempu_c6/zb6;
z1_c6 = Zsempu_c6/zb6;
z2_c6 = z1_c6;
v1_thc6 = 1.046004433 + i*0.0915135298851; %converti pra retangular


%------------------------------------ Matriz de admitancias nodais

Y = zeros(12,12);

Y(1,1) = (1/z1_c1) + (1/zccT12);
Y(2,2) = (1/zccT12) + (1/zL1_23) + (1/zL1_25) + (1/zL1_27);
Y(3,3) = (1/zL1_23) + (1/zccT34) +(1/zL1_39);
Y(4,4) = (1/zccT34) + (1/z1_c4);
Y(5,5) = (1/zL1_25) + (1/zccT56) + (1/zL1_511);
Y(6,6) = (1/zccT56) + (1/z1_c6);
Y(7,7) = (1/zL1_27) + (1/zccT78);
Y(8,8) = (1/zccT78) + (1/z1_c8);
Y(9,9) = (1/zL1_39) + (1/zccT910);
Y(10,10) = (1/zccT910) +(1/z1_c10);
Y(11,11) = (1/zL1_511) + (1/zccT1112);
Y(12,12) = (1/zccT1112) + (1/z1_c12);

Y(1,2) = -(1/zccT12);
Y(2,3) = -(1/zL1_23);
Y(2,5) = -(1/zL1_25);
Y(2,7) = -(1/zL1_27);
Y(3,4) = -(1/zccT34);
Y(3,9) = -(1/zL1_39);
Y(5,6) = -(1/zccT56);
Y(5,11) = -(1/zL1_511);
Y(7,8) = -(1/zccT78);
Y(9,10) = -(1/zccT910);
Y(11,12) = -(1/zccT1112);

for m = 1:12
    for n = 1:12
        Y(n,m) = Y(m,n);
    end
end

% Vetor de correntes

I = zeros(12,1);
I(1,1) = v1_thc1/z1_c1;
I(4,1) = v1_thc4/z1_c4;
I(6,1) = v1_thc6/z1_c6;

% Tensoes nodais

V = (inv(Y)*I)

% ------ Definicao matriz transformadora [T]

a=exp(1i*pi*120/180);
T=[1 1 1;1 a^2 a;1 a a^2];


% ----- Perdas em L511 

i_barra511v2 = (V(5)-V(11))/zL1_511;
i_tot_barra511 = T*[0; i_barra511v2; 0];

sa_barra511 = zL1_511*i_tot_barra511(1)*conj(i_tot_barra511(1));
sb_barra511 = zL1_511*i_tot_barra511(2)*conj(i_tot_barra511(2));
sc_barra511 = zL1_511*i_tot_barra511(3)*conj(i_tot_barra511(3));
S_barra511v2 = sb*(sa_barra511 + sb_barra511 + sc_barra511) %(pegar somente parte ativa) em k

% P = 172.4848433117889 [kW]


% ----- potencia injetada na barra 6 

i_B6 = (v1_thc6-V(6))/z1_c6;
i_B6_tot = T*[0; i_B6; 0];

v_B6 = T*[0 ; V(6) ; 0];

sa_b6 = v_B6(1)*conj(i_B6_tot(1));
sb_b6 = v_B6(2)*conj(i_B6_tot(2));
sc_b6 = v_B6(3)*conj(i_B6_tot(3));
S_B6 = sb*(sa_b6 + sb_b6 + sc_b6) %(pegar todo o complexo) em M

% S = 207.9482171216705 [MW] + 99.21189853253700i [MVAr]

% ----------------------------- defeitos + novos circuitos sem algumas barras (de cargas)


% defeito 25 pra esquerda e 55km pra direita (barra 2-3)/ criamos barra do defeito =7

zL0_ESQ_23 = (25/80)*zL0_23;
zL1_ESQ_23 = (25/80)*zL1_23;
zL2_ESQ_23 = (25/80)*zL2_23;
zL0_DIR_23 = (55/80)*zL0_23;
zL1_DIR_23 = (55/80)*zL1_23;
zL2_DIR_23 = (55/80)*zL2_23;

%----- Matriz de adimitancias + (item b)

Y_1defeito = zeros(7,7);

Y_1defeito(1,1) = (1/z1_c1) + (1/zccT12);
Y_1defeito(2,2) = (1/zccT12) + (1/zL1_ESQ_23) + (1/zL1_25);
Y_1defeito(3,3) = (1/zL1_DIR_23) + (1/zccT34);
Y_1defeito(4,4) = (1/zccT34) + (1/z1_c4);
Y_1defeito(5,5) = (1/zL1_25) + (1/zccT56);
Y_1defeito(6,6) = (1/zccT56) + (1/z1_c6);
Y_1defeito(7,7) = (1/zL1_ESQ_23) + (1/zL1_DIR_23);


Y_1defeito(1,2) = -(1/zccT12);
Y_1defeito(2,5) = -(1/zL1_25);
Y_1defeito(2,7) = -(1/zL1_ESQ_23);
Y_1defeito(3,4) = -(1/zccT34);
Y_1defeito(3,7) = -(1/zL1_DIR_23);
Y_1defeito(5,6) = -(1/zccT56);


for m = 1:7
    for n = 1:7
        Y_1defeito(n,m) = Y_1defeito(m,n);
    end
end

%---------- defeito do 3F

z_defeito3F = 3/zb2;

I_1defeito = zeros(7,1);
I_1defeito(1,1) = v1_thc1*def_mais/z1_c1;
I_1defeito(4,1) = v1_thc4*def_mais/z1_c4;
I_1defeito(6,1) = v1_thc4*def_mais/z1_c6;

V_1defeito = inv(Y_1defeito)*I_1defeito;

Z_1defeito = inv(Y_1defeito);

i1_defeito3F = V_1defeito(7)/(Z_1defeito(7,7) + z_defeito3F);


i1_defeito_base2 = zeros(7,1);
i1_defeito_base2(1,1) = v1_thc1*def_mais/z1_c1;
i1_defeito_base2(4,1) = v1_thc4*def_mais/z1_c4;
i1_defeito_base2(6,1) = v1_thc6*def_mais/z1_c6;
i1_defeito_base2(7,1) = -i1_defeito3F;

V1_defeito_base2 = Z_1defeito * i1_defeito_base2;

i1_defeito27 = (V1_defeito_base2(2) - V1_defeito_base2(7))/zL1_ESQ_23;
Ib2 = sb/(vb2*sqrt(3));
I_fasesABC = (T*[0 ; i1_defeito27 ; 0])*Ib2 %pegar a fase B (mod + fasor)

% Ib =  1418.9332565678 ∠ -172.655525365 [A]

% ------------------------- defeitos matriz adm. - e 0 


Y_0defeito = zeros(7,7);

Y_0defeito(1,1) = (1/z0_c1);
Y_0defeito(2,2) = (1/z0_T12) + (1/zL0_25) + (1/zL0_ESQ_23);
Y_0defeito(3,3) = (1/zL0_DIR_23) + (1/zccT34);
Y_0defeito(4,4) = (1/z0_c4);
Y_0defeito(5,5) = (1/zL0_25) + (1/zccT56);
Y_0defeito(6,6) = (1/z0_c6);
Y_0defeito(7,7) = (1/zL0_ESQ_23) + (1/zL0_DIR_23);

Y_0defeito(2,5) = -(1/zL0_25);
Y_0defeito(2,7) = -(1/zL0_ESQ_23);
Y_0defeito(3,7) = -(1/zL0_DIR_23);


for m = 1:7
    for n = 1:7
        Y_0defeito(n,m) = Y_0defeito(m,n);
    end
end


% -- ajuste outras sequencias - e 0

I_0defeito = zeros(7,1);
I_2defeito = zeros(7,1);

V_0defeito = inv(Y_0defeito)*I_0defeito;
V_2defeito = inv(Y_1defeito)*I_2defeito; %matriz de adm da seq + é igual a seq -

Z_0defeito = inv(Y_0defeito);


% ------ defeito de curto BCN 

z_BC = 3/vb2;
i1_defeitoBC = V_1defeito(7)/(Z_1defeito(7,7) + z_BC + (((Z_0defeito(7,7) + z_BC)* (Z_1defeito(7,7) + z_BC))/(Z_0defeito(7,7) + z_BC + Z_1defeito(7,7) +z_BC)));
i2_defeitoBC = -i1_defeitoBC*(Z_0defeito(7,7)+ z_BC)/(Z_0defeito(7,7) + 2*(z_BC) + Z_1defeito(7,7));
i0_defeitoBC = -i1_defeitoBC*(Z_1defeito(7,7) + z_BC)/(Z_0defeito(7,7)+ 2*(z_BC) + Z_1defeito(7,7));

I_0defeito_BC = zeros(7,1);
I_0defeito_BC(7, 1) = -i0_defeitoBC; 

I_1defeito_BC = zeros(7,1);
I_1defeito_BC(1,1) = v1_thc1*def_mais/z1_c1;
I_1defeito_BC(4,1) = v1_thc4*def_mais/z1_c4;
I_1defeito_BC(6,1) = v1_thc6*def_mais/z1_c6;
I_1defeito_BC(7,1) = -i1_defeitoBC;

I_2defeito_BC = zeros(7,1);
I_2defeito_BC(7,1) = -i2_defeitoBC;
 
V_0defeito_BC = inv(Y_0defeito)*I_0defeito_BC;
V_1defeito_BC = inv(Y_1defeito)*I_1defeito_BC;
V_2defeito_BC = inv(Y_1defeito)*I_2defeito_BC;

i0_BC27 = (V_0defeito_BC(2) - V_0defeito_BC(7))/zL0_ESQ_23; 
i1_BC27 = (V_1defeito_BC(2) - V_1defeito_BC(7))/zL1_ESQ_23;
i2_BC27 = (V_2defeito_BC(2) - V_2defeito_BC(7))/zL1_ESQ_23;

I_abcBC27 = (T*[i0_BC27 ; i1_BC27 ; i2_BC27])* Ib2 %pegar a fase B (mod + fasor)

% Ib =  1388.60 ∠ -161.38 [A]
