%-----------------------------------%
%                                   %
%  ASSIGNMENT_03A                   %
%  Antonio Aristiz�bal Fern�ndez    %
%                                   %
%-----------------------------------%

close all;
clear;
clc;

%% INPUT DATA

delta = 1e-06;
g = 9.81;           % m/s^2

% BEAM GEOMETRY
b = 100e-3;         % m
a = 10e-3;          % m
h = 500e-3;         % m
t = 5e-3;           % m

L = 36;             % m
L1 = 4;             % m
L2 = 12;            % m
M = 55000;          % kg
Me = 3000;          % kg
E = 45e9;           % Pa

%% PREVIOUS CALCULATIONS

% mass center and inertia
beamDiv = [ % [xg_local, yg_local, surface element, surface element]
    0, -h/2, b, t;
    0,    0, h, a;
    0,  h/2, b, t;
];

elem_dim = [        % [base, height] x-direction
   b, t;
   a, h;
   b, t;
];

N = size(beamDiv,1); % number of section elements

[x_cdm,y_cdm,Ixx,Iyy] = inertia(beamDiv,elem_dim,N);

% l parameter
l = l_parameter(L,L1,M,Me,g);

% Open figure window
fig = plotBeams(L);

%% SOLVER

%N_discr = [9, 18, 36, 72, 144, 288]';  % number of discretizations
N_discr = 9;

for p = 1:length(N_discr)
    
dist = (L/2)/(N_discr(p,1));
x_nod = zeros(N_discr(p,1) + 1 ,1);

    for i = 1:(N_discr(p,1) + 1)

        if i == 1
        x_nod(i,1) = 0;

        else
        x_nod(i,1) = dist*(i-1);
    
        end
    end

fixNod = [% Node, DOF, Magnitude;
          % Write the data here...
          1, 1, 0;
          1, 2, 0;    
];

Tmat = [ones(1, (N_discr(p,1) +1))]';

% Material data
mat = [% Young M.   Inertia x    Inertia y
           E,         Ixx,        Iyy;  % Material properties
      ];
  
%% SOLVER

% nodal conectivity matrix
    for j = 1:(N_discr(p,1))
    
         Tn(j,1) = j;
         Tn(j,2) = j + 1;
      
    end

% Dimensions
dim.nd = 2;                         % Number of dimensions
dim.ni = dim.nd;                    % Number of DOFs for each node
dim.nnod = size(x_nod,1);           % Number of nodes for each element
dim.nel = size(Tn,1);               % Total number of elements
dim.nne = size(Tn,2);               % Number of nodes in each bar
dim.ndof = dim.ni*dim.nnod;         % Total number of degrees of freedom


% Computation of the DOFs connectivities
Td = connectDOF(dim,Tn);

% Computation of element stiffness matrices
Kel = stiffnessBars(dim,x_nod,Tn,mat,Tmat);

% Elemet force vector
Fe = Fext_vector(dim,x_nod,Tn,L1,L2,l,g,Me,M,L);

% Global matrix assembly

load('stiffMatrix.mat','KG','Fext');
KG_old = KG;
Fext_old = Fext;

[KG,Fext] = assemblyKG(dim,Td,Kel,Fe);
% save('stiffMatrix','KG','Fext');
[KG] = stiffnessMatrixTest(KG,KG_old,delta);
[Fext] = forceVectorTest(Fext,Fext_old,delta);


% Global system of equations
load('displacements.mat','u');
u_old = u;

[u,R,vl,vr,ur] = solveSystem(dim,KG,Fext,fixNod);
[u] = displacementsTest(u,u_old,delta);
% save('displacements','u');

% Inertial forces Bennding moment
[Fy,Mz,Puy,Ptz] = shear_bend(dim,x_nod,Tn,Td,Kel,u);
%{
%% PLOT RESULTS

N_elem = N_discr(p,1);

[max_displ,max_bend,u_e] = plotBeam1D(x_nod,Puy,Ptz,Fy,Mz,Tn,N_elem,fig);

max_u(p,1) = max_displ;
max_Mz(p,1) = max_bend;
end

figure(fig)
legend(strcat('N=',cellstr(string(N_discr))),'location','northeast');

plotMax_U_Mz(max_u,max_Mz,N_discr);
%}
end