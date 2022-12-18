%Funcao responsavel por fazer a representacao dos 3 graficos finais, da
%malha, temperatura e fluxo

function representacao_grafica(matriz_nos, n1, mc_p1, T, mc_p2, n2, x,...
            cent, fluxos, nos_elemento)

        

%Coordenadas x e y de todos os nos
x1 = matriz_nos(:, 2);
y1 = matriz_nos(:, 3);

%Definicao da escala para representar os vetores de fluxo
if x == 1 %Quad 4 Simples
    
    escala = 0.00000005;
    
elseif x == 2 %Quad 8 Simples
    
    escala = 0.000000009;
    
elseif x == 3 %Quad 4
    
    escala = 0.000005;
    
elseif x == 4 %Quad 8
    
    escala = 0.000004;
    
end



if nos_elemento == 4 %Elemento quadrangular de 4 nos

    %Definicao do nome da janela e dimensoes
    f = figure('Name', 'Malha quadrangular de 4 nós');
    f.Position = [100 200 1300 300];

    for i = 1:n1 %Material 1

        %Conectividade do material
        conectividade_nos = mc_p1(i, :);
        
        %Malha
        
        subplot(1,3,1); %Posicao
        axis([0 max(matriz_nos(:,2)) 0 max(matriz_nos(:,3))]); %Definir eixos
        xlabel('Comprimento (m)'); %Nome das abcsissas
        ylabel('Largura (m)'); %Nome das ordenadas
        title('Representação da malha quandragular de 4 nós'); %Titutlo
        fill(x1(conectividade_nos),y1(conectividade_nos),'w');hold on %Representar malha a branco
        plot(x1,y1,'ok'); %Representar nos com um circulo preto


        %Temperaturas

        subplot(1,3,2); %Posicao
        axis([0 max(matriz_nos(:,2)) 0 max(matriz_nos(:,3))]); %Definir eixos
        xlabel('Comprimento (m)'); %Nome das abcsissas
        ylabel('Largura (m)'); %Nome das ordenadas
        colormap(turbo); %Definir cores utilizadas para "turbo"
        title('Representação a cores da temperatura (ºC)'); %Titutlo
        colorbar; %Colocar barra com legenda das cores
        %Apresentar malha preenchida com os valores de temperatura
        fill (x1(conectividade_nos),y1(conectividade_nos),T(conectividade_nos));hold on 
        plot(x1(conectividade_nos),y1(conectividade_nos),'k');hold on


        %Fluxo

        subplot(1,3,3); %Posicao
        axis([0 max(matriz_nos(:,2)) 0 max(matriz_nos(:,3))]); %Definir eixos
        xlabel('Comprimento (m)'); %Nome das abcsissas
        ylabel('Largura (m)'); %Nome das ordenadas
        title('Representação do fluxo (W/m^2)'); %Titutlo
        fill (x1(conectividade_nos),y1(conectividade_nos),'w'); %Apresentar malha a branco
        hold on
        plot(x1(conectividade_nos),y1(conectividade_nos),'k'); hold on
        plot(cent(i,1),cent(i,2),'kx'); %Representar os pontos de origem dos vetores com um "x"
        hold on
        %Representar vetores de fluxo
        quiver(cent(i,1),cent(i,2),fluxos(i,1),fluxos(i,2), escala);hold on
            
  
    end

    if x == 3 %Se nao for simples


        for i = 1:n2 %Mateiral 2
    
            %Conectividade do material
            conectividade_nos = mc_p2(i, :);
            
            %Malha
            
            subplot(1,3,1); %posicao
            fill(x1(conectividade_nos),y1(conectividade_nos),'w');hold on %Representar malha a branco
            plot(x1,y1,'ok'); %Representar nos com um circulo preto

            %Temperaturas

            subplot(1,3,2); %posicao
            %preencher malha com os valores de temperatura 
            fill (x1(conectividade_nos),y1(conectividade_nos),T(conectividade_nos));hold on
            plot(x1(conectividade_nos),y1(conectividade_nos),'k');hold on

            %Fluxo

            subplot(1,3,3); %posicao
            fill (x1(conectividade_nos),y1(conectividade_nos),'w'); %representacao da malha a branco 
            hold on
            plot(x1(conectividade_nos),y1(conectividade_nos), 'k'); hold on
            plot(cent(n1+i,1),cent(n1+i,2),'kx'); %Representar os pontos de origem dos vetores com um "x"
            hold on
            %Representar vetores de fluxo
            quiver(cent(n1+i,1),cent(n1+i,2),fluxos(n1+i,1),fluxos(n1+i,2), escala);hold on


        end
    end

else %Elemento quandragualr de 8 nos

    %Definicao do nome da janela e dimensoes
    f = figure('Name', 'Malha quadrangular de 8 nós');
    f.Position = [100 200 1300 300];
    
    %Pre alocacoes para representar o fluxo para problema quad8 simples
    media_fluxos = zeros(6,2);
    cent_8 = [0.5 0.5; 1.5 0.5; 2.5 0.5; 0.5 1.5; 1.5 1.5; 2.5 1.5]*1e-3;
    count1 = 1;
    count2 = 2;
    count3 = 3;
    count4 = 4;
    
    if x == 2
        for i = 1:n1 %Material 1

            %Definicao da conectividade do elemento
            no1=mc_p1(i,1) ; 
            no2=mc_p1(i,2) ; 
            no3=mc_p1(i,3) ; 
            no4=mc_p1(i,4) ; 
            no5=mc_p1(i,5) ; 
            no6=mc_p1(i,6) ;
            no7=mc_p1(i,7) ;
            no8=mc_p1(i,8) ;

            conectividade_nos = [no1 no2 no3 no4 no5 no6 no7 no8] ;



            %Malha

            subplot(1,3,1); %Posicao
            axis([0 max(matriz_nos(:,2)) 0 max(matriz_nos(:,3))]); %Definir eixos
            xlabel('Comprimento (m)'); %Nome das abcsissas
            ylabel('Largura (m)'); %Nome das ordenadas
            title('Representação da malha quandragular de 8 nós'); %Titulo
            fill(x1(conectividade_nos),y1(conectividade_nos),'w');hold on %Representar malha a branco
            plot(x1,y1,'ok'); %Representar nos com um circulo preto


            %Temperaturas

            subplot(1,3,2); %Posicao
            axis([0 max(matriz_nos(:,2)) 0 max(matriz_nos(:,3))]); %Definir eixos
            xlabel('Comprimento (m)'); %Nome das abcsissas
            ylabel('Largura (m)'); %Nome das ordenadas
            colormap(turbo); %Definir cores utilizadas para "turbo"
            title('Representação a cores da temperatura (ºC)'); %Titulo
            colorbar;%Colocar barra com legenda das cores
            %Apresentar malha preenchida com os valores de temperatura
            fill (x1(conectividade_nos),y1(conectividade_nos),T(conectividade_nos));hold on
            plot(x1(conectividade_nos),y1(conectividade_nos),'k');hold on


            %Fluxo

            subplot(1,3,3); %Posicao
            axis([0 max(matriz_nos(:,2)) 0 max(matriz_nos(:,3))]); %Definir eixos
            xlabel('Comprimento (m)'); %Nome das abcsissas
            ylabel('Largura (m)'); %Nome das ordenadas
            title('Representação do fluxo (W/m^2)'); %Titulo
            fill (x1(conectividade_nos),y1(conectividade_nos),'w'); %Apresentar malha a branco
            hold on
            plot(x1(conectividade_nos),y1(conectividade_nos),'k'); hold on 
            
            

        

        end
        

        %Loop para calcular a media dos valores dos valores de fluxos por
        %elemento para apenas representar no centroide do elemento
        for w = 1:6

            media_fluxos(w,1) = (fluxos(count1,1) + fluxos(count2,1) + fluxos(count3,1) + fluxos(count4,1))/4;
            media_fluxos(w,2) = (fluxos(count1,2) + fluxos(count2,2) + fluxos(count3,2) + fluxos(count4,2))/4;
            count1 = count1 +4;
            count2 = count2 +4;
            count3 = count3 +4;
            count4 = count4 +4;

        end

        for j = 1:6

            %Representar os pontos de origem dos vetores com um "x"
            plot(cent_8(j,1),cent_8(j,2),'kx');hold on
            %Representar vetores de fluxo
            quiver(cent_8(j,1),cent_8(j,2),fluxos(j,1),fluxos(j,2), escala);hold on


        end
        
    end

    if x == 4 %Se nao for o caso simples
        
        for i = 1:n1 %Material 1

            %Definicao da conectividade do elemento
            no1=mc_p1(i,1) ; 
            no2=mc_p1(i,2) ; 
            no3=mc_p1(i,3) ; 
            no4=mc_p1(i,4) ; 
            no5=mc_p1(i,5) ; 
            no6=mc_p1(i,6) ;
            no7=mc_p1(i,7) ;
            no8=mc_p1(i,8) ;

            conectividade_nos = [no1 no5 no2 no6 no3 no7 no4 no8];


            %Malha

            subplot(1,3,1); %Posicao
            axis([0 max(matriz_nos(:,2)) 0 max(matriz_nos(:,3))]); %Definir eixos
            xlabel('Comprimento (m)'); %Nome das abcsissas
            ylabel('Largura (m)'); %Nome das ordenadas
            title('Representação da malha quandragular de 8 nós'); %Titulo
            fill(x1(conectividade_nos),y1(conectividade_nos),'w');hold on %Representar malha a branco
            plot(x1,y1,'ok'); %Representar nos com um circulo preto


            %Temperaturas

            subplot(1,3,2); %Posicao
            axis([0 max(matriz_nos(:,2)) 0 max(matriz_nos(:,3))]); %Definir eixos
            xlabel('Comprimento (m)'); %Nome das abcsissas
            ylabel('Largura (m)'); %Nome das ordenadas
            colormap(turbo); %Definir cores utilizadas para "turbo"
            title('Representação a cores da temperatura (ºC)'); %Titulo
            colorbar;%Colocar barra com legenda das cores
            %Apresentar malha preenchida com os valores de temperatura
            fill (x1(conectividade_nos),y1(conectividade_nos),T(conectividade_nos));hold on
            plot(x1(conectividade_nos),y1(conectividade_nos),'k');hold on


            %Fluxo

            subplot(1,3,3); %Posicao
            axis([0 max(matriz_nos(:,2)) 0 max(matriz_nos(:,3))]); %Definir eixos
            xlabel('Comprimento (m)'); %Nome das abcsissas
            ylabel('Largura (m)'); %Nome das ordenadas
            title('Representação do fluxo (W/m^2)'); %Titulo
            fill (x1(conectividade_nos),y1(conectividade_nos),'w'); %Apresentar malha a branco
            hold on
            plot(x1(conectividade_nos),y1(conectividade_nos),'k'); hold on 



        end

        for j = 1:size(fluxos,1)

            %Representar os pontos de origem dos vetores com um "x"
            plot(cent(j,1),cent(j,2),'kx');hold on
            %Representar vetores de fluxo
            quiver(cent(j,1),cent(j,2),fluxos(j,1),fluxos(j,2), escala);hold on


        end


        for i = 1:n2 %Material 2

            %Definicao da conectividade do elemento
            no1=mc_p2(i,1) ; 
            no2=mc_p2(i,2) ; 
            no3=mc_p2(i,3) ; 
            no4=mc_p2(i,4) ; 
            no5=mc_p2(i,5) ; 
            no6=mc_p2(i,6) ;
            no7=mc_p2(i,7) ;
            no8=mc_p2(i,8) ;
            conectividade_nos = [no1 no5 no2 no6 no3 no7 no4 no8] ;
            
            %Malha
            
            subplot(1,3,1); %Posicao
            fill(x1(conectividade_nos),y1(conectividade_nos),'w');hold on %Representar malha a branco
            plot(x1,y1,'ok'); %Representar nos com um circulo preto

            %Temperaturas

            subplot(1,3,2); %Posicao
            %Apresentar malha preenchida com os valores de temperatura
            fill (x1(conectividade_nos),y1(conectividade_nos),T(conectividade_nos));hold on
            plot(x1(conectividade_nos),y1(conectividade_nos),'k');hold on

            %Fluxo

            subplot(1,3,3); %Posicao
            %Apresentar malha a branco
            fill (x1(conectividade_nos),y1(conectividade_nos),'w'); 
            hold on
            plot(x1(conectividade_nos),y1(conectividade_nos), 'k'); hold on           

        end

        for j = 1:size(fluxos,1)

            %Representar os pontos de origem dos vetores com um "x"
            plot(cent(j,1),cent(j,2),'kx');hold on
            %Representar vetores de fluxo
            quiver(cent(j,1),cent(j,2),fluxos(j,1),fluxos(j,2), escala);hold on


        end
    end

end
    
 
end

        
    
    
   
