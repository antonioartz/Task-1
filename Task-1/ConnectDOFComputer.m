classdef ConnectDOFComputer < handle

    properties (Access = public)
        Td
    end
    properties (Access = private)
        dim
        data
    end

    methods (Access = public)
        function obj = ConnectDOFComputer(cParams)
            obj.init(cParams);
        end
        function compute(obj)
            obj.connectDOF();
        end
    end
    methods (Access = private)
        function init(obj,cParams)
            obj.dim = cParams.dim;
            obj.data = cParams.data;
        end
        function connectDOF(obj)
            dimensions = obj.dim;
            nel = dimensions.nel;
            ni = dimensions.ni;
            nne = dimensions.nne;
            Tn = obj.data.Tn;
            for e = 1:nel
                for i = 1:nne
                    for j = 1:ni
            
                        I = ni*(i-1) + j;
                        TD(e,I) = ni*(Tn(e,i) - 1) + j;
            
                    end
                end
            end
            obj.Td = TD;
        end
    end
end