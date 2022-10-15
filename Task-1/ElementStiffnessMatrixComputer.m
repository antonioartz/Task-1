classdef ElementStiffnessMatrixComputer < handle

    properties (Access = public)
        KE
    end

    properties (Access = private)
        params
    end

    methods (Access = public)
        function obj = ElementStiffnessMatrixComputer(cParams)
            obj.init(cParams);
        end

        function obj = computeElementStiffnessMatrix(obj)
            le = obj.params.length;
            E = obj.params.E;
            A = obj.params.A;
            Iz = obj.params.Iz;
            coeff1 = Iz*E/(le)^3;
            coeff2 = A*E/le;
            KE = sparse(6,6);
            KE(1,1) = coeff2;
            KE(1,4) = -coeff2;
            KE(2,2) = coeff1*12;
            KE(2,3) = coeff1*6*le;
            KE(2,5) = coeff1*(-12);
            KE(2,6) = coeff1*6*le;
            KE(3,2) = coeff1*6*le;
            KE(3,3) = coeff1*4*le^2;
            KE(3,5) = coeff1*(-6)*le;
            KE(3,6) = coeff1*2*le^2;
            KE(4,1) = -coeff2;
            KE(4,4) = coeff2;
            KE(5,2) = coeff1*(-12);
            KE(5,3) = coeff1*(-6)*le;
            KE(5,5) = coeff1*12;
            KE(5,6) = coeff1*(-6)*le;
            KE(6,2) = coeff1*6*le;
            KE(6,3) = coeff1*2*le^2;
            KE(6,5) = coeff1*(-6)*le;
            KE(6,6) = coeff1*4*le^2;
            obj.KE = KE;
        end
    end

    methods (Access = protected)
        function init(obj,cParams)
            obj.params = cParams.element;
        end
    end

end