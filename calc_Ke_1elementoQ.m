%Esta funcao calcula a matriz de rigidez elementar para os casos de
%elementos quadrangulares de 4 e 8 nós

function [Ke] = calc_Ke_1elementoQ(XN, k1, nos_elemento)

if nos_elemento == 4 %Quad 4
    
    %Pre alocacao da rigidez elementar
    Ke = zeros(4,4);
    
    %gauss-legendre para 2D, 2x2 pontos grau 3
    csi_0=sqrt(1.0/3.0);
    pi=[-csi_0 csi_0 csi_0 -csi_0;-csi_0 -csi_0 csi_0 csi_0]' ;
    w=[1 1 1 1]';

    for i=1:length(w) %Para cada ponto de integracao
        
        %Alocar valores de csi e eta
        csi = pi(i,1); 
        eta = pi(i,2); 

        %Derivada das funcoes de forme em csi e eta
        dvcsi = [-0.25*(1-eta) -0.25*(1-csi); 0.25*(1-eta) -0.25*(1+csi); ...
                    0.25*(1+eta) 0.25*(1+csi); -0.25*(1+eta) 0.25*(1-csi)];
        
        %Derivada de x y em csi e eta
        jacobiana_DP = XN' * dvcsi;

        %Jacobiano da matriz anterior 
        jacobiano_transformacao = det(jacobiana_DP);

        %Calculo da matriz B
        B = dvcsi / (jacobiana_DP);

        %Pesar os pontos de integracao
        wpi = w(i)*jacobiano_transformacao;

        %Calculo da matriz de ridigez elementar
        Ke = k1*wpi*B*B' + Ke;

    end

else %Quad 8

    %Pre alocacao da rigidez elementar
    Ke = zeros(8);
    
    %gauss-legendre para 2D, 3x3 pontos, grau 5
    csi_0=sqrt(0.6);
    pi=[-csi_0 0 csi_0 -csi_0 0 csi_0 -csi_0 0 csi_0; -csi_0 -csi_0 -csi_0... 
    0 0 0 csi_0 csi_0 csi_0]';
    w=[25 40 25 40 64 40 25 40 25]'/81;

    for j = 1:length(w) %Para cada ponto de integracao

        %Alocar valores de csi e eta
        csi = pi(j,1);
        eta = pi(j,2);
        
        %Derivada das funcoes de forme em csi e eta 
        dvcsi(1,1) = (2*csi+eta)*(1-eta)/4;
        dvcsi(2,1) = (2*csi-eta)*(1-eta)/4;
        dvcsi(3,1) = (2*csi+eta)*(1+eta)/4;
        dvcsi(4,1) = (2*csi-eta)*(1+eta)/4;
        dvcsi(5,1) = csi*(eta-1);
        dvcsi(6,1) = (1-eta*eta)/2;
        dvcsi(7,1) = -csi*(1+eta);
        dvcsi(8,1) = (eta*eta-1)/2;
        
        dvcsi(1,2) = (2*eta+csi)*(1-csi)/4;
        dvcsi(2,2) = (2*eta-csi)*(1+csi)/4;
        dvcsi(3,2) = (2*eta+csi)*(1+csi)/4;
        dvcsi(4,2) = (2*eta-csi)*(1-csi)/4;
        dvcsi(5,2) = (csi*csi-1)/2;
        dvcsi(6,2) = -(1+csi)*eta;
        dvcsi(7,2) = (1-csi*csi)/2;
        dvcsi(8,2) = (csi-1)*eta;

        %Derivada de x y em csi e eta
        jacobiana_DP = XN' * dvcsi;

        %Jacobiano da matriz anterior
        jacobiano_transformacao = det(jacobiana_DP);
    
        %Calculo da matriz B
        B = dvcsi / (jacobiana_DP);

        %Pesar os pontos de integracao
        wpi = w(j)*jacobiano_transformacao;

        %Calculo da matriz de ridigez elementar
        Ke = Ke + wpi*B*B'*k1;
     
    end

end
    


end

    
        
     
