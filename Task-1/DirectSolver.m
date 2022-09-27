classdef DirectSolver < Solver

    methods (Access = public)
        function solve(obj)
            obj.x = obj.LHS\obj.RHS;
        end
    end
    methods(Access = public)
        function obj = DirectSolver(cParams)
            obj.init(cParams);
        end
    end

end