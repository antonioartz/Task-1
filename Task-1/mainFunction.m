function [KGlobal, Fe, displacements] = mainFunction(s)  

    % Computation of the DOFs connectivities
    Td = connectDOF(s);
    s.data.Td = Td;

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