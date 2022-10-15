function [KG,Fext,u] = mainFunction(s)

    % Computation of the DOFs connectivities
    Td = connectDOF(s);
    s.data.Td = Td;
    StiffnessMatrix = StiffnessMatrixComputer(s);
    StiffnessMatrix.computeStiffnessMatrix();
    KG = StiffnessMatrix.KG;

    % Elemet force vector
    Fe = Fext_vector(dim,data.x_nod,data.Tn,s,l);

    % Global matrix assembly
    [KG,Fext] = assemblyKG(dim,Td,Kel,Fe);

    % Global system of equations
    [u,R,vl,vr,ur] = solveSystem(dim,KG,Fext,fixNod);

end