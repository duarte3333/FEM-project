%Esta funcao utiliza a data lida do ficheiro .txt para calcular as matrizes
%de rigidez, tal como a matriz simetrica H e o vetor P, caso exista
%convencao, para os casos elementares e faz tambem a assemblagem,
%retornando os vetores globais Bg e Pg utilizados para calcular a
%temperatura

function [Bg, Pg] = CalculosElementares_e_Assemblagem (x, matriz_nos, n1,...
                mc_p1, k1, n2, mc_p2, k2, nr_cf_conv, cf_conv, mc_total,...
                nr_cond_essen, cond_essen, nos_elemento)

%Pre alocacao das matriz globais conforme o numero de nos
Kg = zeros(size(matriz_nos,1));
Hg = zeros(size(matriz_nos,1));
Pg = zeros(size(matriz_nos,1), 1);
    

%Para o material 1
for i = 1:n1 %Para cada elemento
        
        %Guardar conectividade do elemento
        conectividade_nos = mc_p1(i,:); 

        %Coordenadas dos nos do elemento
        xi = matriz_nos(conectividade_nos, 2);
        yi = matriz_nos(conectividade_nos, 3);

        XN = [xi yi];
        
        %Calcular ridigez do elemento
        Ke = calc_Ke_1elementoQ(XN, k1, nos_elemento);
        
        %Fazer a assemblagem na matriz global de Ke 
        Kg(conectividade_nos, conectividade_nos) = ...
            Kg(conectividade_nos, conectividade_nos) + Ke;


 end


%No caso de existir um segundo material
if x == 3 || x == 4

    for i = 1:n2 %Para cada elemento do segundo material

        %Guardar conectividade do elemento
        conectividade_nos = mc_p2(i,:);
        
        %Coordenadas dos nos do elemento
        xi = matriz_nos(conectividade_nos, 2);
        yi = matriz_nos(conectividade_nos, 3);

        XN = [xi yi];
        
        %Calcular ridigez do elemento
        Ke = calc_Ke_1elementoQ(XN, k2, nos_elemento);

        %Fazer a assemblagem na matriz global de Ke 
        Kg(conectividade_nos, conectividade_nos) = ...
            Kg(conectividade_nos, conectividade_nos) + Ke;


    end

end

%Calculo das matrizes de convencao
if nr_cf_conv ~= 0 %Caso exista conveccao

    for i = 1:nr_cf_conv

        if nos_elemento == 4 %Quad 4

            elem = cf_conv(i,1); %Elemento em questao
            
            %Coordenadas do no1
            n1 = [matriz_nos(cf_conv(i,2), 2) ...
                matriz_nos(cf_conv(i,2), 3)];
            %Coordenadas do no2
            n2 = [matriz_nos(cf_conv(i,3), 2) ...
                matriz_nos(cf_conv(i,3), 3)];
            
            %Constante de convencao
            beta = cf_conv(i, 4);
            
            %Temperatura longe da parede
            T = cf_conv(i, 5);
            
            %Distancia entre os 2 nos
            h = norm(n1-n2);

            %Posicao de cada um dos nos, conforme apresentada na matriz de
            %conectividades
            pos = [find(mc_total(cf_conv(i,1), :) == cf_conv(i,2)) ...
                    find(mc_total(cf_conv(i,1), :) == cf_conv(i,3))];
            
            %Conectividade do elemento
            conectividade_nos = mc_total(elem, :);


            %Caso os nos estejam na posicao 1 e 2
            if (pos(1,1) == 1 && pos(1,2) == 2) || ...
                    (pos(1,1) == 2 && pos(1,2) == 1)

                %Calcular He
                He = h*beta*(1/6)*[2 1 0 0; 1 2 0 0; ...
                    0 0 0 0; 0 0 0 0];
                
                %Calcular Pe
                Pe = h*beta*T*(1/2)*[1; 1; 0; 0];

         
            %Caso os nos estejam na posicao 2 e 3
            elseif (pos(1,1) == 2 && pos(1,2) == 3) || ...
                    (pos(1,1) == 3 && pos(1,2) == 2)

                %Calcular He
                He = h*beta*(1/6)*[0 0 0 0; 0 2 1 0; ...
                    0 1 2 0; 0 0 0 0];

                %Calcular Pe
                Pe = h*beta*T*(1/2)*[0; 1; 1; 0];

             

            %Caso os nos estejam na posicao 3 e 4
            elseif (pos(1,1) == 3 && pos(1,2) == 4) || ...
                    (pos(1,1) == 4 && pos(1,2) == 3)

                %Calcular He
                He = h*beta*(1/6)*[0 0 0 0; 0 0 0 0; ...
                    0 0 2 1; 0 0 1 2];
                
                %Calcular Pe
                Pe = h*beta*T*(1/2)*[0; 0; 1; 1];
        
            %Caso os nos estejam na posicao 1 e 4
            elseif (pos(1,1) == 1 && pos(1,2) == 4) || ...
                    (pos(1,1) == 4 && pos(1,2) == 1)

               %Calcular He
               He = h*beta*(1/6)*[2 0 0 1; 0 0 0 0; ...
                    0 0 0 0; 1 0 0 2];

               %Calcular Pe
               Pe = h*beta*T*(1/2)*[1; 0; 0; 1];

           
            end
            
            %Assemblagem de Hg e Pg
            Hg(conectividade_nos, conectividade_nos) = ...
                    Hg(conectividade_nos, conectividade_nos) + He;
                
            Pg(conectividade_nos, 1) = ...
                    Pg(conectividade_nos, 1) + Pe;

        else %Quad 8
            
            %Guardar conectividade do elemento
            conectividade_nos = cf_conv(i, 2:4);

            %Coordenadas dos nos 1 2 e 3
            n1 = [matriz_nos(cf_conv(i,2), 2) ...
                matriz_nos(cf_conv(i,2), 3)];

            n2 = [matriz_nos(cf_conv(i,3), 2) ...
                matriz_nos(cf_conv(i,3), 3)];

            n3 = [matriz_nos(cf_conv(i,4), 2) ...
                matriz_nos(cf_conv(i,4), 3)];

            %Constante de convencao
            beta = cf_conv(i, 5);

            %Temperatura longe da parede
            T = cf_conv(i, 6);

            %Calculo da matriz H e P elementar atraves da funcao auxilair
            %calc_robin_quad() pois para Quad8 as matrizes utilizadas em
            %Quad4 ficam demasiado extensas
            [He, Pe] = calc_robin_quad(n1, n2, n3, beta, T);

            %Assemblagem de Hg e Pg
            Hg(conectividade_nos, conectividade_nos) = ...
                    Hg(conectividade_nos, conectividade_nos) + He;

            Pg(conectividade_nos, 1) = ...
                    Pg(conectividade_nos, 1) + Pe;


        end

    end

end


 
%Definicao matriz global 

Bg = Kg + Hg;   

%Aplicacao das condicoes essenciais para que a temperatura tenha valores
%especificos em determinados nos
boom = 1.0e+16; %numero muito elevado

for i = 1:nr_cond_essen 
    
    Bg(cond_essen(i,1), cond_essen(i,1)) = boom;
    Pg(cond_essen(i,1)) = Pg(cond_essen(i,1)) + boom*cond_essen(i,2);
  
    
end


end
            
            
            
            
    

       
        
       