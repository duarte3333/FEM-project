%Esta funcao utiliza toda a data lida do ficheiro .txt e trata-a de modo a
%ser mais facil trabalhar com ela

function [nr_nos, matriz_nos, nr_elementos, cond_essen, ...
    cf_conv, mc_total, mc_p1, mc_p2, n1, n2, k1, k2, x, tipo_elemento, ...
    nr_carregamentos_dist, carregamentos_dist, nr_cond_essen, ...
    nr_cargas_pontuais, cargas_pontuais, nr_cf, cf,  nr_cf_conv, nos_elemento  ] = ...
    escolher_data() 

%Chamar a funcao ler_ficheiro()
[nr_nos, matriz_nos, nr_elementos, matriz_de_conectividade, ...
nr_materiais, materiais, nr_carregamentos_dist, carregamentos_dist, ...
nr_cond_essen, cond_essen, nr_cargas_pontuais, ...
cargas_pontuais, nr_cf, cf,  nr_cf_conv, cf_conv, tipo_elemento, x, nos_elemento] = ler_ficheiro();

% Filtrar a matriz de conectividade
mc_total = matriz_de_conectividade(:, 4:end); %da 4 coluna para a frente



% Criar matrizes de conectividade para cada material

if (x == 1) || (x == 2) %Nos casos simples
        mc_p1 = matriz_de_conectividade(:, 4:end); %Ler a partir de 4 coluna para a frente
        mc_p2 = 0;  %Nao ha segundo material
        cf_conv = 0; %Nao ha convencao
        
else %Casos importando do nx
        
        for i = 1:nr_elementos %Para cada elemento
            
            if matriz_de_conectividade(i,2) == 1 %Caso o seja material 1
                
                mc_p1(i, :) = matriz_de_conectividade(i, 4:end); %Guardar na matriz do material 1
            
            else %Caso seja o material 2
                
                mc_p2(i, :) = matriz_de_conectividade(i,4:end); %Guardar na matriz do material 2
                
            end
        end
        
        %Remontar a matriz do segundo material
        mc_p2 = reshape(nonzeros(mc_p2), length(nonzeros(mc_p2))...
                 /nos_elemento,nos_elemento );
        
end

% Numero de elementos para cada material 
n1 = size(mc_p1, 1); %Material 1
n2 = size(mc_p2, 1); %Material 2

%Condutividades termicas para cada material
k1 = materiais(1,2);
k2 = [];
if (nr_materiais > 1)
    k2 = materiais(2,2);
end


end