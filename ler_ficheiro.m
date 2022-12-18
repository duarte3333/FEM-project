%Esta funcao le toda a data do ficheiro .txt no formato pedido e guarda-a
%em variaveis que podem (ou nao) ser utilizadas no resto do projeto

function [nr_nos, matriz_nos, nr_elementos, matriz_de_conectividade, ...
    nr_materiais, materiais, nr_carregamentos_dist, carregamentos_dist, ...
    nr_cond_essen, cond_essen, nr_cargas_pontuais, ...
     cargas_pontuais, nr_cf, cf,  nr_cf_conv, cf_conv, tipo_elemento, x, nos_elemento] = ...
    ler_ficheiro()

%Perguntar ao utilizador na consola qual malha pretende utilizar para
%resolver o problema em questao
    prompt = "Qual malha pretende executar?\n" + ...
        "1 - Quadrangular de 4 nós simples\n" + ...
        "2 - Quadrangular de 8 nós simples\n" + ...
        "3 - Quandragular de 4 nós\n" + ...
        "4 - Quadrangular de 8 nós\n";
    
%Guardar resposta do utilizador
x = input(prompt);

%Numero de nos por elemento
nos_elemento = 4;

%So sao resolvidos problemas com elementos quadrangulares
tipo_elemento = 4;          

%Definir nome do ficheiro conforme o problema a resolver
if (x == 1)
    nome_ficheiro = 'malha_quadrangular_simples_4.txt';
    
elseif (x == 2)
    nome_ficheiro = 'malha_quadrangular_simples_8.txt';
    nos_elemento = 8; %mudar o numero de nos por elemento para 8
    
elseif (x == 3)
    nome_ficheiro = 'malha_quadrangular_4.txt';
    
else
    nome_ficheiro = 'malha_quadrangular_8.txt';
    nos_elemento = 8; %mudar o numero de nos por elemento para 8
end

%Abrir o ficheiro .txt e ler a primeira linha sem contar com o \n
data = fopen(['./' nome_ficheiro], 'r');
fgetl(data); %Avanca o ponteiro para a segunda linha


fgetl(data); %Avanca o ponteiro para a terceira linha
%Le a terceira linha e guarda o primeiro "float" que encontra, o numero de nos
nr_nos = fscanf(data, '%f', 1); 

%Le a linha e guarda como coluna numa matriz 
matriz_nos = fscanf (data, '%e', [3 inf]); %Le todos os nos e avanca o ponteiro
matriz_nos = matriz_nos'; %Matriz transposta
tmp = nr_nos;

while (tmp ~= 0)     %passar os nos para metros
    matriz_nos(tmp,2) = matriz_nos(tmp,2)*0.001;
    matriz_nos(tmp,3) = matriz_nos(tmp,3)*0.001;
    tmp = tmp - 1;
end

%Matriz de conectividades
fgetl(data); %Avancar ponteiro pois data nao e necessaria
nr_elementos = fscanf (data, '%f', 1); %numero de elementos
matriz_de_conectividade = fscanf (data, '%e', [(3+nos_elemento) inf]);
matriz_de_conectividade = matriz_de_conectividade'; %Matriz transposta

%Propriedades dos materiais
fgetl(data); 
nr_materiais = fscanf (data, '%f', 1); %Numero de materiais
materiais = fscanf(data, '%e', [2 inf]);
materiais = materiais'; %Maitrz trasnposta

%Carregamentos distribuidos
fgetl(data);
nr_carregamentos_dist = fscanf (data, '%f', 1); %Numero de carregamentos distribuidos
carregamentos_dist = fscanf(data, '%e', [2 inf]);
carregamentos_dist = carregamentos_dist'; %Matriz transposta

%Condicoes de fronteira essenciais
fgetl(data);
nr_cond_essen = fscanf (data, '%f', 1);
cond_essen = fscanf (data, '%e', [2 inf]);
cond_essen = cond_essen'; %Matriz transposta

%Cargas pontuais
fgetl(data);
nr_cargas_pontuais = fscanf (data, '%f', 1);
cargas_pontuais = fscanf (data, '%e', [3 inf]);
cargas_pontuais = cargas_pontuais'; %Matriz transposta

%Fluxo na fronteira (tambem e condicoes de fronteira)
fgetl(data);
nr_cf = fscanf(data, '%f', 1);
cf = fscanf(data, '%e', [4 inf]);
cf = cf'; %Matriz transposta

%Convencao natural

if nos_elemento == 4 %Caso seja Quad4

    fgetl(data);
    nr_cf_conv = fscanf(data, '%f', 1);
    cf_conv = fscanf(data, '%e', [5 inf]); %Le ate a 5 coluna
    cf_conv = cf_conv'; %Matriz transposta

else %Caso seja Quad8

    fgetl(data);
    nr_cf_conv = fscanf(data, '%f', 1);
    cf_conv = fscanf(data, '%e', [6 inf]); %Le ate a 6 coluna (ha mais uma coluna de temperatura)
    cf_conv = cf_conv'; %Matriz transposta

end

end

