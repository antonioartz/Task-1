classdef DisplacementsComputer < handle

    properties (Access = public)
        u
        dim
        fixedNodes
        KLL, KLR, FL
        KG
        Fext
        vl, vr
        ul, ur
        solverType
    end
 
    methods (Access = public)
        function obj = DisplacementsComputer(cParams)
            obj.init(cParams)
        end

        function compute(obj)
            obj.loadNodeStatus();
            obj.computeFixedDisplacements();
            obj.computeFreeDisplacements();
            obj.assembleDisplacements();
        end
    end

    methods (Access = private)
        function init(obj,cParams)
            obj.KG = cParams.KG;
            obj.Fext = cParams.Fext;
            obj.solverType = cParams.solverType;
            obj.fixedNodes = cParams.data.fixNod;
            obj.dim = cParams.dim;
        end

        function loadNodeStatus(obj)
            Nodes = NodeStatusComputer(obj);
            Nodes.compute();
            obj.vl = Nodes.vl;
            obj.vr = Nodes.vr;
        end

        function computeFixedDisplacements(obj)
            fixNod = obj.fixedNodes;
            obj.ur(:,1) = fixNod(:,3);
        end

        function computeFreeDisplacements(obj)
            DecomposeKG = StiffnessMatrixDecomposer(obj);   
            DecomposeKG.decompose();
            obj.KLL = DecomposeKG.KLL;
            obj.KLR = DecomposeKG.KLR;
            obj.FL = DecomposeKG.FL; 
            
            FreeDisp = FreeDisplacementsSolver(obj);
            FreeDisp.compute();
            obj.ul = FreeDisp.ul;
        end

        function assembleDisplacements(obj)
            free = obj.vl; fixed = obj.vr;
            displacements(free,1) = obj.ul;
            displacements(fixed,1) = obj.ur;
            obj.u = displacements;
        end

    end
end