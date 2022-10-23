function [KGlobal, Fe, displacements] = mainFunction(s)  

    % Computation of the DOFs connectivities
    connect = ConnectDOFComputer(s);
    connect.compute();
    s.data.Td = connect.Td;

    % Global Stiffness Matrix
    StiffnessMatrix = StiffnessMatrixComputer(s);
    StiffnessMatrix.compute();
    KGlobal = StiffnessMatrix.KG;


    % Global force vector
    ForceVector = ForceVectorComputer(s);
    ForceVector.compute();
    Fe = ForceVector.Fext;
   
    s.KGlobal = KGlobal; s.Fe = Fe;
    Displacements = DisplacementsComputer(s);
    Displacements.compute();
    displacements = Displacements.u;

end