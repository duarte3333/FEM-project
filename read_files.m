% The function reads all data from .txt file in the format requested 
% and store them in variables that will be used further on
function [nb_nodes, nodes_matrix, nb_elements, connectivity_matrix, ...
    nb_materials, materials, nb_dist_loads, load_dist, ...
    nb_essen_cond, essen_cond, nb_imp_loads, ...
     imp_loads, nb_cf, cf,  nb_cf_conv, cf_conv, x, type_element] = ...
    read_files()

    prompt = "Which method you want?\n" + ...
        "1 - triangular mesh\n" + ...
        "2 - simple triangular mesh\n" + ...
        "3 - quadrangular mesh\n" + ...
        "4 - simple quadrangular mesh\n";
    x = input(prompt);
    type_element = 3;
    if (x == 1)
        file_name = 'malha_triangular.txt';
    elseif (x == 2)
        file_name = 'malha_triangular_simples.txt';
    elseif (x == 3)
        file_name = 'malha_quadrangular.txt';
        type_element = 4;
    else
        file_name = 'malha_quadrangular_simples.txt';
        type_element = 4;
    end

    %Open the .txt file and read the first line discarding the \n
    data = fopen(['./' file_name], 'r');
    fgetl(data); %It also advance the pointer to the second line

    %Nodes matrix
    fgetl(data); %Read second line and advance the pointer to the third line
    nb_nodes = fscanf(data, '%f', 1); %Read third line and gets the first float of the line

    %Read a line and keep as a column in a matrix 3 X (number of nodes)
    nodes_matrix = fscanf (data, '%e', [3 inf]); %Read all node's coordinates and advance pointer
    nodes_matrix = nodes_matrix'; %transpose the matrix
    tmp = nb_nodes;
    while (tmp ~= 0)     %multiply by 0.001 all entries
        nodes_matrix(tmp,2) = nodes_matrix(tmp,2)*0.001;
        nodes_matrix(tmp,3) = nodes_matrix(tmp,3)*0.001;
        tmp = tmp - 1;
    end

    %Connectivity matrix
    fgetl(data);
    nb_elements = fscanf (data, '%f', 1); %number of elements
    connectivity_matrix = fscanf (data, '%e', [(3+type_element) inf]);
    connectivity_matrix = connectivity_matrix'; %transpose

    %Material Properties
    fgetl(data);
    nb_materials = fscanf (data, '%f', 1); %number of materials
    materials = fscanf(data, '%e', [2 inf]);
    materials = materials'; %transpose
    
    %Distributed loads
    fgetl(data);
    nb_dist_loads = fscanf (data, '%f', 1); %number os distributed loads
    load_dist = fscanf(data, '%e', [2 inf]);
    load_dist = load_dist'; %transpose

    %Essential Border Condition
    fgetl(data);
    nb_essen_cond = fscanf (data, '%f', 1);
    essen_cond = fscanf (data, '%e', [2 inf]);
    essen_cond = essen_cond'; %transpose
    
    %Imposed Point Loads
    fgetl(data);
    nb_imp_loads = fscanf (data, '%f', 1);
    imp_loads = fscanf (data, '%e', [3 inf]);
    imp_loads = imp_loads'; %transpose
    
    %Flux at the Border
    fgetl(data);
    nb_cf = fscanf(data, '%f', 1);
    cf = fscanf(data, '%e', [4 inf]);
    cf = cf'; %transpose
    
    %Natural Convection
    fgetl(data);
    nb_cf_conv = fscanf(data, '%f', 1);
    cf_conv = fscanf(data, '%e', [5 inf]);
    cf_conv = cf_conv'; %transpose

end

