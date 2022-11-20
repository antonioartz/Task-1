classdef NodeStatusComputer < handle

    properties (Access = public)
        vl
        vr
    end
    properties (Access = private)
        fixedNodes
        dim
    end

    methods (Access = public)
        function obj = NodeStatusComputer(cParams)
            obj.init(cParams);
        end
        function compute(obj)
            obj.computeNodeStatus();
        end
    end
    

    methods (Access = private)
        function init(obj,cParams)
            obj.fixedNodes = cParams.fixedNodes;
            obj.dim = cParams.dim;
        end
                function computeNodeStatus(obj)
            ndof = obj.dim.ndof;
            ni = obj.dim.ni;
            fixNod = obj.fixedNodes;
            free = zeros(size(fixNod,1),1);
            for i = 1:size(fixNod,1)
                 free(i,1) = ni*(fixNod(i,1) - 1 ) + fixNod(i,2);
            end

            fixed = [1:ndof]';
            fixed(free) = [];

            obj.vr = free;
            obj.vl = fixed;
        end
    end
end