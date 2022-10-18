function [KGlobal, Fe] = mainFunction(s)       % [KG,Fext,u]

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
   
    %{
    % Global system of equations
    [u,R,vl,vr,ur] = solveSystem(dim,KG,Fext,fixNod);
    %}

end