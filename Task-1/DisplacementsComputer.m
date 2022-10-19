classdef DisplacementsComputer < handle

    properties (Access = public)
        u
        fixedNodes
        dim
    end

    properties (Access = private)
        solverType
        vl, vr
        ul, ur
        KG
        Fext
    end
 
    methods (Access = public)
        function obj = DisplacementsComputer(cParams)
            obj.init(cParams)
        end

        function computeDisplacements(obj)
            obj.loadNodeStatus();
            obj.computeFixedDisplacements();
            obj.computeFreeDisplacements();
            obj.assembleDisplacements();
        end
    end

    methods (Access = private)
        function init(obj,cParams)
            obj.KG = cParams.KGlobal;
            obj.Fext = cParams.Fe;
%            obj.solverType = cParams.solverType;
            obj.fixedNodes = cParams.data.fixNod;
            obj.dim = cParams.dim;
        end

        function loadNodeStatus(obj)
            Nodes = NodeStatusComputer(obj);
            Nodes.computeNodeStatus();
            obj.vl = Nodes.vl;
            obj.vr = Nodes.vr;
        end

        function computeFixedDisplacements(obj)
            fixNod = obj.fixedNodes;
            obj.ur(:,1) = fixNod(:,3);
        end

        function computeFreeDisplacements(obj)
            KGlobal = obj.KG; Fe = obj.Fext;
            free = obj.vl; fixed = obj.vr;
            KLL = KGlobal(free,free);
            KLR = KGlobal(free,fixed);
            KRL = KGlobal(fixed,free);
            KRR = KGlobal(fixed,fixed);
            FL = Fe(free,1);
            FR = Fe(fixed,1);
        
            s.LHS = KLL;
            s.RHS = FL - KLR*obj.ur;
        
            s.solverType = 'Direct';
            %s.solverType = 'Iterative';
        
            Solv = Solver.create(s);
            Solv.solve();
            obj.ul = Solv.x;
        end

        function assembleDisplacements(obj)
            free = obj.vl; fixed = obj.vr;
            displacements(free,1) = obj.ul;
            displacements(fixed,1) = obj.ur;
            obj.u = displacements;
        end

    end
end