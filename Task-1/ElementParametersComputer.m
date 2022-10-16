classdef ElementParametersComputer < handle

    properties (Access = public)
        length        
        E, A, Iz
    end

    properties (Access = private)
        data
        x1, x2
        y1, y2
    end

    methods (Access = public)
        function obj = ElementParametersComputer(cParams)
            obj.init(cParams); 
        end

        function obj = elementProperties(obj,e)
            X = obj.data.x_nod;
            node1 = obj.data.Tn(e,1);
            node2 = obj.data.Tn(e,2);
            obj.x1 = X(node1,1); obj.x2 = X(node2,1);
            obj.y1 = X(node1,2); obj.y2 = X(node2,2);
            obj.length = obj.computeElementLenght();
            Mat = obj.data.mat;
            Tmat = obj.data.Tmat(e);
            obj.E = Mat(Tmat,1);
            obj.A = Mat(Tmat,2);
            obj.Iz = Mat(Tmat,3);
        end

        function [x1, x2, y1, y2] = computeNodeCoordinates(obj)
            x1 = obj.x1; x2 = obj.x2;
            y1 = obj.y1; y2 = obj.y2;
        end
    end

    methods (Access = protected)
        function init(obj,cParams)
            obj.data = cParams.data;
        end
    end

    methods (Access = private)
        function length = computeElementLenght(obj)
            [x1, x2, y1, y2] = obj.computeNodeCoordinates();
            length = sqrt((x1 - x2)^2 + (y1 - y2)^2);
        end
    end

end