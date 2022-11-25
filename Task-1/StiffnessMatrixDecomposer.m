classdef StiffnessMatrixDecomposer < handle

        properties (Access = public)
                KLL
                KLR
        end
        properties (Access = private)
                KGlobal
                Fe
                free, fixed
        end

        methods (Access = public)
                function obj = StiffnessMatrixDecomposer(cParams)
                        obj.init(cParams)
                end
                function decompose(obj)
                        obj.decomposer();
                end
        end
        methods (Access = private)
                function init(obj,cParams)
                        obj.KGlobal = cParams.KG; 
                        obj.free = cParams.vl; obj.fixed = cParams.vr; 
                end
                function decomposer(obj)
                        obj.KLL = obj.KGlobal(obj.free,obj.free);          
                        obj.KLR = obj.KGlobal(obj.free,obj.fixed);
                end
        end
end