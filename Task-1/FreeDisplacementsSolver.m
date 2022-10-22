classdef FreeDisplacementsSolver < handle
    properties (Access = public)
        ul
    end
    properties (Access = private)
        KLL
        KLR
        FL
        ur
        solverType
    end

    methods (Access = public)
        function obj = FreeDisplacementsSolver(cParams)
            obj.init(cParams);
        end
        function compute(obj)
            obj.solveDisplacements();
        end
    end
    methods (Access = private)
        function init(obj,cParams)
            obj.solverType = cParams.solverType;
            obj.KLL = cParams.KLL;
            obj.KLR = cParams.KLR;
            obj.FL = cParams.FL;
            obj.ur = cParams.ur;
        end
        function solveDisplacements(obj)
            s.LHS = obj.KLL;                 
            s.RHS = obj.FL - obj.KLR*obj.ur;
            s.solverType = obj.solverType;
            Solv = Solver.create(s);
            Solv.solve();
            obj.ul = Solv.x;
        end
    end
end