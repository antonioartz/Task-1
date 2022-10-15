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

g = 9.81;           % m/s^2

% BEAM GEOMETRY:

% BEAM A
d = 150e-3;
r = d/2;
t_a = 8e-3;

% BEAM B
b = 50e-3;         % m
h = 70e-3;          % m
t_b = 5e-3;         % m

L = 0.65;            % m
H1 = 1.9;            % m
H2 = 2.6;            % m
r_w = 0.25;          % m
alpha = 7*pi/180;    % rad
E = 180e9;           % Pa
v = 260/3.6;         % m/s
Io = 180;            % kg m^2
t_f = 2.5;           % s
fr_coeff = 0.45;

%% INERTIA
% mass center and inertia

% Inertia Beam A

I_xa = (1/4)*pi*((r + t_a/2)^4 - (r - t_a/2)^4);
I_ya = I_xa;

Aa = pi*(r + t_a/2)^2 - pi*(r - t_a/2)^2;

% Intertia Beam B

beamDiv = [ % [xg_local, yg_local, surface element, surface element]
    0, -h/2, b, t_b;
    0, 0, h, t_b;
    0, h/2, b, t_b;
];

elem_dim = [        % [b, h]
   b, t_b;
   t_b, h;
   b, t_b;
];

N = size(beamDiv,1); % number of cross-section elements

[x_cdm,y_cdm,I_xb,I_yb,Ab] = inertia(beamDiv,elem_dim,N);

%% FORCES

[Ny,Nx,frx,fry,N,fr] = comp_forces(v,alpha,Io,r_w,t_f,fr_coeff);


%% SOLVER

s.data.x_nod = [
    0,      H2;
    0, H2 - H1;
    0,       0;
    L,      H2;
];

s.data.Tn = [
    1, 2;
    2, 3;
    4, 2;
];

s.data.Tmat = [
    2; 2; 1;
];

s.data.fixNod = [% Node, DOF, Magnitude;
     
          1, 1, 0;
          1, 2, 0;
          1, 3, 0;
          4, 1, 0;
          4, 2, 0;
          4, 3, 0;
];

s.data.fdata = [
    3, 2, Ny + fry;
    3, 1, Nx - frx;
];

% Material data
s.data.mat = [% Young M.    Area       Inertia z    Inertia x
           E,         Aa,        I_xa,        I_ya;  % Material properties
           E,         Ab,        I_xb,        I_yb;
      ];

% Dimensions
s.dim.nd = 3;                         % Number of dimensions
s.dim.ni = s.dim.nd;                  % Number of DOFs for each node
s.dim.nnod = size(s.data.x_nod,1);    % Number of nodes for each element
s.dim.nel = size(s.data.Tn,1);        % Total number of elements
s.dim.nne = size(s.data.Tn,2);        % Number of nodes in each bar
s.dim.ndof = s.dim.ni*s.dim.nnod;     % Total number of degrees of freedom

s.tolerance = 1e-06;
s.desiredTest = 'StiffnessMatrix';
%s.desiredTest = 'ForceVector';
%s.desiredTest = 'Displacements';
Test = TestComputer.testSelector(s);
Test.check();