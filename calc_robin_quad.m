%Calculo das matrizes elementares He e Pe para Quad8
function [He, Pe] = calc_robin_quad(n1, n2, n3, beta, T)

%Pre alocacao das matrizes H e P
He = zeros(3);
Pe = zeros(3,1);

%Gauss-Legendre 1D, 3 pontos, grau 5
csi_0=sqrt(0.6);
pi=[-csi_0 0 csi_0];
w=[5; 8; 5]/9;

for i = 1:length(w) %Para cada ponto de integracao

    %Determinar csi
    csi = pi(i);

    %Funcoes de forma
    vcsi = [1/2*csi*(csi-1); 1-csi^2; 1/2*csi*(csi+1)];

    %Derivada das funcoes de forme em csi e eta
    dvcsi = [csi-1/2; -2*csi; csi+1/2];
    
    %Lados do "triangulo" para calcular o jacobiano 
    dxdcsi = dvcsi(1)*n1(1) + dvcsi(2)*n2(1) + dvcsi(3)*n3(1);
    dydcsi = dvcsi(1)*n1(2) + dvcsi(2)*n2(2) + dvcsi(3)*n3(2);
    %Teorema de pitagoras
    jaco = sqrt(dxdcsi^2 + dydcsi^2);

    %Pesar os pontos e multiplicar por p (beta) e gama (beta*T)
    wip =jaco*w(i);
    wipB =wip*beta;
    wipBT =wip*beta*T;

    %Calcular as matrizes elementares He e Pe
    He = He + wipB*vcsi*vcsi';
    Pe = Pe + wipBT*vcsi;

end


end