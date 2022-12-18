%Funcao que utiliza as matrizes globais Bg e Pg que foram calculadas, tal
%como outras variaveis definidas anteriormente para calcular a temperatura,
%gradiente e fluxo, tal como os pontos onde estes vetores estao definidos

function [T, fluxos, cent, grad] = calculo_temperatura_fluxo(Bg, Pg, nr_elementos,...
            n1, mc_p1, matriz_nos, k1, x, n2, mc_p2, k2, nos_elemento)

%Calculo de temperaturas
T = Bg\Pg;


if nos_elemento == 4 %Quad4

%Pre alocacao das matrizes
fluxos = zeros(nr_elementos,2); 
grad = zeros(nr_elementos,2);
cent = zeros(nr_elementos, 2);
    
    for i = 1:n1 %Para o material 1
        
        %Guardar conectividade do elemento 
        conectividade_nos = mc_p1(i, :);
        
        %Coordenadas dos nos do elemento
        xi = matriz_nos(conectividade_nos, 2);
        yi = matriz_nos(conectividade_nos, 3);

        XN = [xi yi];
        
        %Centroide esta na origem do quadrado standard
        eta = 0;
        csi = 0;
        
        %Funcoes de forma
        vcsi = [ 0.25*(1-csi)*(1-eta); 0.25*(1+csi)*(1-eta); ...
            0.25*(1+csi)*(1+eta); 0.25*(1-csi)*(1+eta)];
        
        %Derivada das funcoes de forma em csi e eta
        dvcsi = [-0.25*(1-eta) -0.25*(1-csi); 0.25*(1-eta) -0.25*(1+csi); ...
            0.25*(1+eta) 0.25*(1+csi); -0.25*(1+eta) 0.25*(1-csi)];
        
        %Jacobiana (transforamcao de coordenadas)
        J = XN' * dvcsi;
        
        %Calculo de B
        B = dvcsi / J;
        
        %Temperatura dos nos deste elemento
        T_nos = T(conectividade_nos);
        
        %Calculo do gradiente
        grad(i, :) = B' * T_nos;
        
        %Calculo do fluxo
        fluxos(i,:) = -k1 * grad(i,:);
        
        %Aplicar transformacao de coordandas para saber o centroide do
        %elemento (real)
        cent(i,:) = XN' * vcsi;
     
             
    end
    
    if x == 3 %Se nao for o caso simples
        
        for i = 1:n2 %Material 2
        
             %Guardar conectividade do elemento 
            conectividade_nos = mc_p2(i, :);

            %Coordenadas dos nos do elemento
            xi = matriz_nos(conectividade_nos, 2);
            yi = matriz_nos(conectividade_nos, 3);

            XN = [xi yi];

            %Centroide esta na origem do quadrado standard
            eta = 0;
            csi = 0;

            %Funcoes de forma
            vcsi = [ 0.25*(1-csi)*(1-eta); 0.25*(1+csi)*(1-eta); ...
                0.25*(1+csi)*(1+eta); 0.25*(1-csi)*(1+eta)];

            %Derivada das funcoes de forma em csi e eta
            dvcsi = [-0.25*(1-eta) -0.25*(1-csi); 0.25*(1-eta) -0.25*(1+csi); ...
                0.25*(1+eta) 0.25*(1+csi); -0.25*(1+eta) 0.25*(1-csi)];

            %Jacobiana (transformacao de coordenadas)
            J = XN' * dvcsi;

            %Calculo de B
            B = dvcsi / J;

            %Temperatura dos nos deste elemento
            T_nos = T(conectividade_nos);

            %Calculo do gradiente
            grad(n1+i, :) = B' * T_nos;

            %Calculo do fluxo
            fluxos(n1+i,:) = -k2 * grad(n1+i,:);

            %Aplicar transformacao de coordandas para saber o centroide do
            %elemento (real)
            cent(n1+i,:) = XN' * vcsi;

             
        end
    
    end

else %Elemento quadrangular de 8 nos

%Pre alocacao das matrizes que vao ser utilizados, para Quad8 o gradiente e
%o fluxo e calculado em 4 pontos de integracao, pelo que cada elemento tem
%4 fluxos/gradientes associados
fluxos = zeros(nr_elementos*4,2);
grad = zeros(nr_elementos*4,2);
cent = zeros(nr_elementos*4, 2);
count = 1; %Contagem comeca em 1, usado em matrizes grad e fluxos

   for i = 1:n1 %Material 1
        
        %Guardar conectividade do elemento 
        conectividade_nos = mc_p1(i, :);

        %Coordenadas dos nos do elemento
        xi = matriz_nos(conectividade_nos, 2);
        yi = matriz_nos(conectividade_nos, 3);

        %Temperatura dos nos deste elemento
        T_nos = T(conectividade_nos);

        XN = [xi yi];

        %Gauss-Legendre 2D 4 pontos de integracao reduzida
        csi_0=sqrt(1.0/3.0);
        pi=[-csi_0 csi_0 csi_0 -csi_0;-csi_0 -csi_0 csi_0 csi_0]' ;
        w=[1 1 1 1]';

        for j = 1:length(w) %Para cada ponto de integracao

            %Alocar valores de csi e eta
            csi = pi(j,1);
            eta = pi(j,2);

            %Funcoes de forma
            vcsi = [(csi-1)*(eta+csi+1)*(1-eta)/4 (1+csi)*(1-eta)*(csi-eta-1)/4 ...
                    (1+csi)*(1+eta)*(csi+eta-1)/4 (csi-1)*(csi-eta+1)*(1+eta)/4 ...
                    (1-csi*csi)*(1-eta)/2 (1+csi)*(1-eta*eta)/2 ...
                    (1-csi*csi)*(1+eta)/2 (1-csi)*(1-eta*eta)/2]';

            %Derivada das funcoes de forma em csi e eta
            dvcsi = [(2*csi+eta)*(1-eta)/4 (2*eta+csi)*(1-csi)/4; ...
                     (2*csi-eta)*(1-eta)/4 (2*eta-csi)*(1+csi)/4; ...
                     (2*csi+eta)*(1+eta)/4 (2*eta+csi)*(1+csi)/4; ...
                     (2*csi-eta)*(1+eta)/4 (2*eta-csi)*(1-csi)/4; ...
                     csi*(eta-1) (csi*csi-1)/2; ...
                     (1-eta*eta)/2 -(1+csi)*eta; ...
                     -csi*(1+eta) (1-csi*csi)/2; ...
                     (eta*eta-1)/2 (csi-1)*eta];

            %Jacobiana (transformacao de coord)
            J = XN' * dvcsi;

            %Calculo da matriz B
            B = dvcsi / J;
            
            %Calculo do gradiente
            grad(count, :) = B' * T_nos;

            %Calculo do fluxo
            fluxos(count ,:) = -k1 * grad(count,:);
        
            %Calculo do ponto em que o gradiente e o fluxo em questao estao
            %aplicados
            cent(count,:) = XN' * vcsi;
        
            %Contagem sobe 1, para as matrizes grad e fluxos
            count = count + 1;


        end
        

    end

    if x == 4 %Caso exista material 2

        for i = 1:n2 %Repeteri raciocinio para material 2

            %Guardar conectividade do elemento 
            conectividade_nos = mc_p2(i, :);

            %Coordenadas dos nos do elemento
            xi = matriz_nos(conectividade_nos, 2);
            yi = matriz_nos(conectividade_nos, 3);

            %Temperatura dos nos deste elemento
            T_nos = T(conectividade_nos);

            XN = [xi yi];

            %Gauss-Legendre 2D 4 pontos de integracao reduzida
            csi_0=sqrt(1.0/3.0);
            pi=[-csi_0 csi_0 csi_0 -csi_0;-csi_0 -csi_0 csi_0 csi_0]' ;
            w=[1 1 1 1]';

            for j = 1:length(w) %Para cada ponto de integracao

                %Alocar valores de csi e eta
                csi = pi(j,1);
                eta = pi(j,2);

                 %Funcoes de forma
                vcsi = [(csi-1)*(eta+csi+1)*(1-eta)/4 (1+csi)*(1-eta)*(csi-eta-1)/4 ...
                    (1+csi)*(1+eta)*(csi+eta-1)/4 (csi-1)*(csi-eta+1)*(1+eta)/4 ...
                    (1-csi*csi)*(1-eta)/2 (1+csi)*(1-eta*eta)/2 ...
                    (1-csi*csi)*(1+eta)/2 (1-csi)*(1-eta*eta)/2]';


                %Derivada das funcoes de forma em csi e eta
                dvcsi = [(2*csi+eta)*(1-eta)/4 (2*eta+csi)*(1-csi)/4; ...
                         (2*csi-eta)*(1-eta)/4 (2*eta-csi)*(1+csi)/4; ...
                         (2*csi+eta)*(1+eta)/4 (2*eta+csi)*(1+csi)/4; ...
                         (2*csi-eta)*(1+eta)/4 (2*eta-csi)*(1-csi)/4; ...
                         csi*(eta-1) (csi*csi-1)/2; ...
                         (1-eta*eta)/2 -(1+csi)*eta; ...
                         -csi*(1+eta) (1-csi*csi)/2; ...
                         (eta*eta-1)/2 (csi-1)*eta];

                %Jacobiano da matriz anterior (transformacao de coord)
                J = XN' * dvcsi;

                %Calculo da matriz B
                B = dvcsi / J;

                %Calculo do gradiente
                grad(count, :) = B' * T_nos;

                %Calculo do fluxo
                fluxos(count ,:) = -k2 * grad(count,:);

                 %Calculo do ponto em que o gradiente e o fluxo em questao estao
                %aplicados
                cent(count,:) = XN' * vcsi;

                %Contagem sobe 1, para as matrizes grad e fluxos
                count = count + 1;


            end

        end

    end

       
        
end

end