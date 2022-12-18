%Funcao principal que chama todas as outras funcoes do projeto para simular
%um problema de conducacao de calor de uma placa.

%Ao executar este script, ira aparecer uma mensagem na consola que pergunta
%qual problema o utilizador pretende resolver, sendo as opções "Malha
%quandragular de 4 nos simples, Malha quandragular de 8 nos simples, Malha
%quandragular de 4 nos e Malha quandragular de 8 nos". Os dois últimos
%casos referem-se a resolucao do problema importando do software comercial.

%Apos a escolha do utilizador, o programa ira apresentar uma janela com 3
%placas, uma com apenas a malha, uma com a malha e placa, tal como 
%a representacao da temperatura ao longo da mesma e uma com a malha e
%placa, tal como a representacao vetorial do fluxo. Na consola é
%sao apresentados os seguintes resultados: temperatura nodal, gradiente e
%fluxo.

function main()

%Limpar variaveis e consola
clear all;
clc;
 
%Chamar funcao que lê os dados do ficheiro .txt
[nr_nos, matriz_nos, nr_elementos, cond_essen, ...
    cf_conv, mc_total, mc_p1, mc_p2, n1, n2, k1, k2, x, tipo_elemento, ...
    nr_carregamentos_dist, carregamentos_dist, nr_cond_essen, ...
    nr_cargas_pontuais, cargas_pontuais, nr_cf, cf,  nr_cf_conv, nos_elemento] = ...
    escolher_data();

%Calculo das matrizes globais que resolvem o problema
[Bg, Pg] = CalculosElementares_e_Assemblagem (x, matriz_nos, n1,...
                mc_p1, k1, n2, mc_p2, k2, nr_cf_conv, cf_conv, mc_total,...
                nr_cond_essen, cond_essen, nos_elemento);

%Calculo da temepratura nodal, fluxo, gradiente e coordenadas dos centroides do
%fluxo e gradiente
[T, fluxos, cent, grad] = calculo_temperatura_fluxo(Bg, Pg, nr_elementos,...
            n1, mc_p1, matriz_nos, k1, x, n2, mc_p2, k2, nos_elemento);

%Representacao das 3 placas na janela grafica final
representacao_grafica(matriz_nos, n1, mc_p1, T, mc_p2, n2, x,...
            cent, fluxos, nos_elemento);

%Apresentacao da temperatura nodal, gradiente e fluxo na consola
resultados(T,grad,fluxos);

end