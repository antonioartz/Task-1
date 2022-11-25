classdef FEMComputer < handle

    properties (Access = public)
        KG
        Fext
        u
        dim
        data
        solverType
        KLL
        KLR
        FL
        vl
        vr
    end

    methods (Access = public)
        function obj = FEMComputer(cParams)
            obj.init(cParams);
        end
        function compute(obj)
            obj.computeDOF();
            obj.computeStiffnessMatrix();
            obj.computeForceVector();
            obj.computeDisplacements();
        end
    end
    methods (Access = private)
        function init(obj,cParams)
            obj.dim = cParams.dim;
            obj.data = cParams.data;
            obj.solverType = cParams.solverType;
        end
        function computeDOF(obj)
            connect = ConnectDOFComputer(obj);
            connect.compute();
            obj.data.Td = connect.Td;
        end
        function computeStiffnessMatrix(obj)
            StiffnessMatrix = StiffnessMatrixComputer(obj);
            StiffnessMatrix.compute();
            obj.KG = StiffnessMatrix.KG;
            obj.vl = StiffnessMatrix.vl;
            obj.vr = StiffnessMatrix.vr;
            obj.KLL = StiffnessMatrix.KLL;
            obj.KLR = StiffnessMatrix.KLR;
        end
        function computeForceVector(obj)
            ForceVector = ForceVectorComputer(obj);
            ForceVector.compute();
            obj.Fext = ForceVector.Fext;
            obj.FL = ForceVector.FL;
        end
        function computeDisplacements(obj)
            Displacements = DisplacementsComputer(obj);
            Displacements.compute();
            obj.u = Displacements.u;
        end
    end
end