classdef Solver < handle

    properties (Access = public)
        x
    end
    properties (Access = protected)
        LHS
        RHS
    end

    methods (Static, Access = public)
        function obj = create(cParams)

            switch cParams.solver_type
            case {'Direct'}
                obj = DirectSolver(cParams);

            case {'Iterative'}
                obj = IterativeSolver(cParams);

            otherwise
                error('Invalid solver type')
            end
        end
    end

    methods (Access = protected)
        function init(obj,cParams)
            obj.LHS = cParams.LHS;
            obj.RHS = cParams.RHS;
        end
    end
end