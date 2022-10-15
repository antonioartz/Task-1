classdef StiffnessMatrixComputer < handle

    properties (Access = public)
        KG
        KElement
        element
    end
    properties (Access = private)
        dim
        data
    end

    methods (Access = public)
        function obj = StiffnessMatrixComputer(cParams)
            obj.init(cParams);
        end

        function obj = computeStiffnessMatrix(obj)
            obj.computeElementStiffness();
            obj.assembleStiffnessMatrix();
        end
    end

    methods (Access = protected)
        function init(obj, cParams)
            obj.dim = cParams.dim;
            obj.data = cParams.data;
        end
    end

    methods (Access = private)
        function computeElementStiffness(obj)
            nel = obj.dim.nel;
            nne = obj.dim.nne;
            ni = obj.dim.ni;
            KElement = zeros(nne*ni,nne*ni,nel);
            for e = 1:nel
                obj.element = obj.loadElementParameters(e);
                Re = obj.loadRotationMatrix();
                KBase = obj.loadElementStiffnessMatrix();
                KE = transpose(Re)*KBase*Re;
                KElement(:,:,e) = KE;
            end
       obj.KElement = KElement;
        end

        function assembleStiffnessMatrix(obj)
            Td = obj.data.Td;
            ndof = obj.dim.ndof;
            nne = obj.dim.nne;
            ni = obj.dim.ni;
            nel = obj.dim.nel;
            KG = zeros(ndof,ndof);
            for e = 1:nel
                for i = 1:nne*ni
                    I = Td(e,i);
                    for j = 1:nne*ni
                        J = Td(e,j);
                        Kel = obj.KElement(i,j,e);
                        KG(I,J) = KG(I,J) + Kel;
                    end
                end
            end
            obj.KG = KG;
        end

        function element = loadElementParameters(obj,e)
            s.data = obj.data;
            element = ElementParametersComputer(s);
            element.elementProperties(e);
        end

        function Re = loadRotationMatrix(obj)
            s = obj.element;
            RM = RotationMatrixComputer(s);
            RM.computeRotationMatrix();
            Re = RM.rotationMatrix;
        end

        function KBase = loadElementStiffnessMatrix(obj)
            s.element = obj.element;
            Kel = ElementStiffnessMatrixComputer(s);
            Kel.computeElementStiffnessMatrix();
            KBase = Kel.KE;
        end
    end

end