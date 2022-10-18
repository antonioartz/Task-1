classdef StiffnessMatrixComputer < handle

    properties (Access = public)
        KG
    end
    properties (Access = private)
        dim
        data
        KElement
    end

    methods (Access = public)
        function obj = StiffnessMatrixComputer(cParams)
            obj.init(cParams);
        end

        function computeStiffnessMatrix(obj)
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
            KElem = zeros(nne*ni,nne*ni,nel);
            for e = 1:nel
                element = obj.loadElementParameters(e);
                Re = obj.loadRotationMatrix(element);
                KBase = obj.loadElementStiffnessMatrix(element);
                KE = transpose(Re)*KBase*Re;
                KElem(:,:,e) = KE;
            end
       obj.KElement = KElem;
        end

        function assembleStiffnessMatrix(obj)
            Td = obj.data.Td;
            ndof = obj.dim.ndof;
            nne = obj.dim.nne;
            ni = obj.dim.ni;
            nel = obj.dim.nel;
            KGlobal = zeros(ndof,ndof);
            for e = 1:nel
                for i = 1:nne*ni
                    I = Td(e,i);
                    for j = 1:nne*ni
                        J = Td(e,j);
                        Kel = obj.KElement(i,j,e);
                        KGlobal(I,J) = KGlobal(I,J) + Kel;
                    end
                end
            end
            obj.KG = KGlobal;
        end

        function element = loadElementParameters(obj,e)
            s.data = obj.data;
            element = ElementParametersComputer(s);
            element.elementProperties(e);
        end
    end
    methods (Access = private, Static)
        function Re = loadRotationMatrix(element)
            s = element;
            RM = RotationMatrixComputer(s);
            RM.computeRotationMatrix();
            Re = RM.rotationMatrix;
        end

        function KBase = loadElementStiffnessMatrix(element)
            s.element = element;
            Kel = ElementStiffnessMatrixComputer(s);
            Kel.computeElementStiffnessMatrix();
            KBase = Kel.KE;
        end
    end

end