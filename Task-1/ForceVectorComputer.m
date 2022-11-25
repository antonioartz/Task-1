classdef ForceVectorComputer < handle

    properties (Access = public)
        Fext
        FL
    end

    properties (Access = private)
        dim
        fdata
        vl
    end

        methods (Access = public)
            function obj = ForceVectorComputer(cParams)
                obj.init(cParams);
            end

            function compute(obj)
                obj.forceVectorComputation();
                obj.decomposeForceVector();
            end
        end
        
        methods (Access = private)
            function init(obj,cParams)
                obj.dim = cParams.dim;
                obj.fdata = cParams.data.fdata;
                obj.Fext = cParams.Fext;
                obj.vl = cParams.vl;
            end
            function forceVectorComputation(obj)
                forceData = obj.fdata;
                ndof = obj.dim.ndof;
                ni = obj.dim.ni;
                Fe = zeros(ndof,1);
                for i = 1:height(forceData)
                    Fe((ni*forceData(i,1)) - forceData(i,2),1) = forceData(i,3);
                end
                obj.Fext = Fe;
            end
            function decomposeForceVector(obj)
                obj.FL = obj.Fext(obj.vl,1);

            end
        end
end