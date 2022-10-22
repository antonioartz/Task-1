classdef RotationMatrixComputer < handle

    properties (Access = public)
        rotationMatrix
    end
    properties (Access = private)
        element
    end

    methods (Access = public)
        function obj = RotationMatrixComputer(cParams)
            obj.init(cParams);
        end
        function compute(obj)
            obj.computeRotationMatrix();
        end
    end


    methods (Access = private)
        function init(obj,cParams)
            obj.element = cParams;
        end
        function obj = computeRotationMatrix(obj)
            elem = obj.element;
            le = elem.length;
            x1 = elem.x1; x2 = elem.x2;
            y1 = elem.y1; y2 = elem.y2;
            Re = sparse(6,6);
            Re(1,1) =  (x2 - x1);
            Re(1,2) =  (y2 - y1);
            Re(2,1) = -(y2 - y1);
            Re(2,2) =  (x2 - x1);
            Re(3,3) =  le       ;
            Re(4,4) =  (x2 - x1);
            Re(4,5) =  (y2 - y1);
            Re(5,4) = -(y2 - y1);
            Re(5,5) =  (x2 - x1);
            Re(6,6) =  le       ;
            obj.rotationMatrix = Re*1/le;
        end
    end

end