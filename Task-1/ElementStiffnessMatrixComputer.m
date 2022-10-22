classdef ElementStiffnessMatrixComputer < handle

    properties (Access = public)
        KElement
    end

    properties (Access = private)
        dim
        data
    end

    methods (Access = public)
        function obj = ElementStiffnessMatrixComputer(cParams)
            obj.init(cParams);
        end
        function compute(obj)
            obj.computeElementStiffnessMatrix();
        end

    end

    methods (Access = private)
        function init(obj,cParams)
            obj.dim = cParams.dim;
            obj.data = cParams.data;
        end

        function computeElementStiffnessMatrix(obj)
            nel = obj.dim.nel;
            nne = obj.dim.nne;
            ni = obj.dim.ni;
            KElem = zeros(nne*ni,nne*ni,nel);
            for e = 1:nel
                element = obj.loadElementParameters(e);
                Re = obj.loadRotationMatrix(element);
                KBase = obj.loadElementStiffnessMatrix(element);
                KEl = transpose(Re)*KBase*Re;
                KElem(:,:,e) = KEl;
            end
        obj.KElement = KElem;
        end

        function element = loadElementParameters(obj,e)
            s.data = obj.data;
            element = ElementParametersComputer(s);
            element.compute(e);
        end
    end
    methods (Access = private, Static)
        function Re = loadRotationMatrix(element)
            s = element;
            RM = RotationMatrixComputer(s);
            RM.compute();
            Re = RM.rotationMatrix;
        end

        function KBase = loadElementStiffnessMatrix(element)
            le = element.length;
            E = element.E;
            A = element.A;
            Iz = element.Iz;
            coeff1 = Iz*E/(le)^3;
            coeff2 = A*E/le;
            KEl = sparse(6,6);
            KEl(1,1) = coeff2;
            KEl(1,4) = -coeff2;
            KEl(2,2) = coeff1*12;
            KEl(2,3) = coeff1*6*le;
            KEl(2,5) = coeff1*(-12);
            KEl(2,6) = coeff1*6*le;
            KEl(3,2) = coeff1*6*le;
            KEl(3,3) = coeff1*4*le^2;
            KEl(3,5) = coeff1*(-6)*le;
            KEl(3,6) = coeff1*2*le^2;
            KEl(4,1) = -coeff2;
            KEl(4,4) = coeff2;
            KEl(5,2) = coeff1*(-12);
            KEl(5,3) = coeff1*(-6)*le;
            KEl(5,5) = coeff1*12;
            KEl(5,6) = coeff1*(-6)*le;
            KEl(6,2) = coeff1*6*le;
            KEl(6,3) = coeff1*2*le^2;
            KEl(6,5) = coeff1*(-6)*le;
            KEl(6,6) = coeff1*4*le^2;
            KBase = KEl;
        end
    end
end