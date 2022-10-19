function [KGlobal, Fe, displacements] = mainFunction(s)  

    % Computation of the DOFs connectivities
    Td = connectDOF(s);
    s.data.Td = Td;

    % Global Stiffness Matrix
    StiffnessMatrix = StiffnessMatrixComputer(s);
    StiffnessMatrix.computeStiffnessMatrix();
    KGlobal = StiffnessMatrix.KG;


    % Global force vector
    ForceVector = ForceVectorComputer(s);
    ForceVector.computeForceVector();
    Fe = ForceVector.Fext;
   
    s.KGlobal = KGlobal; s.Fe = Fe;
    Displacements = DisplacementsComputer(s);
    Displacements.computeDisplacements();
    displacements = Displacements.u;

end