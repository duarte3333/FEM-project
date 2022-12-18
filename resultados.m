%Funcao responsavel por apresentar na consola os valores da temperatura
%nodal, tal como o modulo do gradiente e fluxo

function [fluxos] = resultados(T,grad,fluxos)

for i = 1:length(fluxos(:,1)) 
    
    %Guardar em vetores os valores em x e y do fluxo e gradiente
    v = [fluxos(i,1) fluxos(i,2)];
    w = [grad(i,1) grad(i,2)];
    
    %Determinacao da norma do gradiente e fluxo e alocacao na 3 coluna das
    %matrizes
    fluxos(i,3) = norm(v);
    grad(i,3) = norm(w);
    
end

format shortG %Definicao do formato do texto

%Apresentar a temperatura nodal e os modulos do gradiente e fluxo
disp('Os valores de temperatura (ºC) em cada nó obtidos foram:')
disp(T)
disp('O módulo do gradiente (ºC/m) em cada ponto integração obtido foi:')
disp(grad(:,3))
disp('O módulo do fluxo (W/m^2) em cada ponto integração obtido foi:')
disp(fluxos(:,3))

end