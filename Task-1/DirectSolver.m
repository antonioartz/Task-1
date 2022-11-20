classdef DirectSolver < Solver

    methods (Access = public)
        function solve(obj)
            %obj.x = obj.LHS\obj.RHS;
            obj.x = inv(obj.LHS)*obj.RHS;
        end
        function obj = DirectSolver(cParams)
            obj.init(cParams);
        end
    end

end