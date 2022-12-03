%The function takes all data taken from reading the .txt file and
% choose only the useful variables to the heat conduction problem
function [nb_nodes, nodes_matrix, nb_elements, essen_cond, ...
    cf_conv, mc_total, mc_p1, mc_p2, n1, n2, k1, k2] = ...
    choose_data () 

%Call the read_files() function
[nb_nodes, nodes_matrix, nb_elements, connectivity_matrix, ...
nb_materials, materials, nb_dist_loads, load_dist, ...
nb_essen_cond, essen_cond, nb_imp_loads, ...
imp_loads, nb_cf, cf,  nb_cf_conv, cf_conv, x, type_element] = read_files()

% Filter the connectivity matrix 
mc_total = connectivity_matrix(:, 4:(3 + type_element)); %until 6 or 7 column

last = [93 170; 12 0; 77 142; 6 0];
%For example, 93 and 170 are the last index of material 1 and 2, respectively, in case 1
% Separation connectivity matrix for each material
if (x == 1)   %case 1
        mc_p1 = connectivity_matrix(1:last(1,1),:);
        mc_p2 = connectivity_matrix((last(1,1) + 1):last(1,2),:);     
elseif (x == 2) %case 2
        mc_p1 = connectivity_matrix(1:last(2,1),:);
        mc_p2 = 0;  
        cf_conv = 0;
elseif (x == 3) %case 3
        mc_1 = connectivity_matrix(1:last(3,1),:);
        mc_2 = connectivity_matrix((last(3,1) + 1):last(3,2),:);  
else
        mc_1 = connectivity_matrix(1:last(4,1),:);
        mc_2 = 0;  
        cf_conv = 0;
end
% Number of elements in the incidence matrix of each of the materials
n1 = size(mc_1, 1);
n2 = size(mc_2, 1);

%Thermal conductivities
k1 = materials(1,2);
k2 = [];
if (nb_materials > 1)
    k2 = materials(2,2);
end
%Transpose connectivity matrix
mc_total = mc_total';

end