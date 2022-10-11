function [KG,Fext,u] = mainFunction(s)

%% PREVIOUS CALCULATIONS

% mass center and inertia
beamDiv = [ % [xg_local, yg_local, surface element, surface element]
    0, -s.h/2, s.b, s.t;
    0,    0, s.h, s.a;
    0,  s.h/2, s.b, s.t;
    ];

elem_dim = [        % [base, height] x-direction
    s.b, s.t;
    s.a, s.h;
    s.b, s.t;
    ];

N = size(beamDiv,1); % number of section elements

[x_cdm,y_cdm,Ixx,Iyy] = inertia(beamDiv,elem_dim,N);

% l parameter
l = l_parameter(s);

% Open figure window
%fig = plotBeams(L);

%% SOLVER

%N_discr = [9, 18, 36, 72, 144, 288]';  % number of discretizations
N_discr = 9;

for p = 1:length(N_discr)

    dist = (s.L/2)/(N_discr(p,1));
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
        s.E,         Ixx,        Iyy;  % Material properties
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
    Fe = Fext_vector(dim,x_nod,Tn,s,l);

    % Global matrix assembly

    %load('stiffMatrix.mat','KG','Fext');
    %KG_old = KG;
    %Fext_old = Fext;

    [KG,Fext] = assemblyKG(dim,Td,Kel,Fe);
    % save('stiffMatrix','KG','Fext');
    %[KG] = stiffnessMatrixTest(KG,KG_old,delta);
    %[Fext] = forceVectorTest(Fext,Fext_old,delta);


    % Global system of equations
    %load('displacements.mat','u');
    %u_old = u;

    [u,R,vl,vr,ur] = solveSystem(dim,KG,Fext,fixNod);
    %[u] = displacementsTest(u,u_old,tolerance);
    end
end