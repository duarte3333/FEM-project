for i = 1:length(fluxos(:,1)) 
    
    %Guardar em vetores os valores em x e y do fluxo e gradiente
    v = [fluxos(i,1) fluxos(i,2)];
    w = [grad(i,1) grad(i,2)];
    
    %Determinacao da norma do gradiente e fluxo e alocacao na 3 coluna das
    %matrizes
    fluxos(i,3) = norm(v);
    grad(i,3) = norm(w);
    
end

media = zeros(nr_elementos,1);
count1 = 1;
count2 = 2;
count3 = 3;
count4 = 4;
tamanho = size(fluxos)/4;
for i = 1:tamanho
    
    media(i) = (fluxos(count1,3) + fluxos(count2,3) + fluxos(count3,3) + fluxos(count4,3))/4;
    count1 = count1 +4;
    count2 = count2 +4;
    count3 = count3 + 4;
    count4 = count4 +4;
    
end

for i = 1:nr_cf_conv
    
    
    if nos_elemento == 8
        elem = cf_conv(i,1);

        n1 = matriz_nos(cf_conv(i,2), 3);
        n2 = matriz_nos(cf_conv(i,3), 3);
        n3 = matriz_nos(cf_conv(i,4), 3);

        A = [abs(n1-n2); abs(n1-n3); abs(n2-n3)];
        h = max(A);
        fluxo = media(elem);

        P(i) = fluxo * h;
        
    else
        
        elem = cf_conv(i,1);
        n1 = matriz_nos(cf_conv(i,2), 3);
        n2 = matriz_nos(cf_conv(i,3), 3);
        h = abs(n1-n2);
        fluxo = abs(fluxos(elem));
        P(i) = fluxo * h;
    end
     
end
P1T = 0;
for j = 1:9
    
    P1T = P1T + P(j);
    
end
P2T = 0;
for w = 10:18
    
    P2T = P2T+P(w);
    
end

if nos_elemento == 4
    P1_4 = P(1:9)';
    P2_4 = P(10:18)';
    P1T_4 = P1T;
    P2T_4 = P2T;
    
else 
    P1_8 = P(1:9)';
    P2_8 = P(10:18)';
    P1T_8 = P1T;
    P2T_8 = P2T;
    
end
