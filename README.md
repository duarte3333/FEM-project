
# Creating a FEM software with Matlab

## Explanation
Finite element analysis (FEA) is a
widely used technique for analyzing
the behavior of structures and systems 
under various loads and conditions. In this work, we present a method for 
creating a finite element model (FEM) 
in Matlab to solve heat transfer problems. 
The FEM developed in this work allows the 
user to analyze the temperature distribution 
in a structure or system under specified heat 
sources and boundary conditions. The FEM is 
created using a mesh of interconnected elements, 
each with defined material properties and heat 
transfer characteristics. 
The global stiffness 
matrix is assembled to represent the overall 
heat transfer characteristics of the structure 
or system, and is used to solve for the element 
temperatures. The results of the analysis can 
be visualized using Matlab's visualization tools, 
allowing the user to understand the temperature 
distribution in the structure or system. 
Through this work, we hope to provide 
a useful tool for engineers and researchers 
looking to analyze heat transfer problems using FEA.

For a more detailed explanation and to see 
the project statement, you can see 
the .pdf file that are inside the repository.

## Results
To verify that we made a good software, 
we compared the results obtained by Matlab 
with a commercial software already quite 
successful called Siemens NX.
![Screenshot from 2022-12-20 21-05-57](https://user-images.githubusercontent.com/76222459/208766737-67eb36ba-30a7-40a2-be3b-73c85785ed10.png)
On the left is the distribution of the temperature 
obtained on Siemens NX and in the right the obtained in the Matlab.
![Screenshot from 2022-12-20 21-06-27](https://user-images.githubusercontent.com/76222459/208767018-5eb7009d-22ce-4675-8596-63c0e6c24968.png)
On the left is the heat flux distribution
obtained on Siemens NX and in the right the obtained in the Matlab.

## Flowchart

![Screenshot from 2022-12-20 21-06-44](https://user-images.githubusercontent.com/76222459/208767298-c1979dc6-ef2e-4d28-a987-4915b7b4160e.png)

## Authors
This work was carried out jointly with 
two other colleagues: Carlota Barros 
and João Dias within the scope of the 
Computational Mechanics discipline of 
the mechanical engineering degree at 
the Instituto Superior Técnico.
