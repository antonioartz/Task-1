classdef DisplacementsComputer < handle

    properties (Access = public)
        u
        dim
        fixedNodes
        KLL, KLR, FL
        vl, vr
        ul, ur
        solverType
    end
 
    methods (Access = public)
        function obj = DisplacementsComputer(cParams)
            obj.init(cParams)
        end

        function compute(obj)
            obj.computeFixedDisplacements();
            obj.computeFreeDisplacements();
            obj.assembleDisplacements();
        end
    end

    methods (Access = private)
        function init(obj,cParams)
            obj.solverType = cParams.solverType;
            obj.fixedNodes = cParams.data.fixNod;
            obj.dim = cParams.dim;
            obj.KLL = cParams.KLL;
            obj.KLR = cParams.KLR;
            obj.FL = cParams.FL;
            obj.vl = cParams.vl;
            obj.vr = cParams.vr;
        end

        function computeFixedDisplacements(obj)
            fixNod = obj.fixedNodes;
            obj.ur(:,1) = fixNod(:,3);
        end

        function computeFreeDisplacements(obj)            
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