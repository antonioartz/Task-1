classdef IterativeSolver < Solver

    methods (Access = public)
        function solve(obj)
            obj.x = pcg(obj.LHS,obj.RHS,[],10000);
        end
        function obj = IterativeSolver(cParams)
            obj.init(cParams);
        end
    end
end