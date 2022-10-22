classdef ElementParametersComputer < handle

    properties (Access = public)
        length        
        E, A, Iz
        x1, x2
        y1, y2
    end

    properties (Access = private)
        data
    end

    methods (Access = public)
        function obj = ElementParametersComputer(cParams)
            obj.init(cParams); 
        end
        function compute(obj,e)
            obj.elementProperties(e);
            obj.elementMaterial(e);
        end

    end

    methods (Access = private)
        function init(obj,cParams)
            obj.data = cParams.data;
        end
        
        function elementProperties(obj,e)
            X = obj.data.x_nod;
            node1 = obj.data.Tn(e,1);
            node2 = obj.data.Tn(e,2);
            obj.x1 = X(node1,1); obj.x2 = X(node2,1);
            obj.y1 = X(node1,2); obj.y2 = X(node2,2);
            obj.length = obj.computeElementLenght();
        end
        function elementMaterial(obj,e)
            Mat = obj.data.mat;
            Tmat = obj.data.Tmat(e);
            obj.E = Mat(Tmat,1);
            obj.A = Mat(Tmat,2);
            obj.Iz = Mat(Tmat,3);            
        end
        function length = computeElementLenght(obj)
            X1 = obj.x1; X2 = obj.x2;
            Y1 = obj.y1; Y2 = obj.y2;
            length = sqrt((X1 - X2)^2 + (Y1 - Y2)^2);
        end
    end

end