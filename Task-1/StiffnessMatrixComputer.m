classdef StiffnessMatrixComputer < handle

    properties (Access = public)
        KG
        dim
        data
        vl, vr
        KLL
        KLR
        fixedNodes
    end
    properties (Access = private)
        KElement
    end

    methods (Access = public)
        function obj = StiffnessMatrixComputer(cParams)
            obj.init(cParams);
        end

        function compute(obj)
            obj.computeElementStiffness();
            obj.assembleStiffnessMatrix();
            obj.loadNodeStatus();
            obj.decomposeStiffnessMatrix();
        end
    end

    methods (Access = private)
        function init(obj, cParams)
            obj.dim = cParams.dim;
            obj.data = cParams.data;
            obj.fixedNodes = cParams.data.fixNod;
        end

        function computeElementStiffness(obj)
            ElementK = ElementStiffnessMatrixComputer(obj);
            ElementK.compute();
            obj.KElement = ElementK.KElement;
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
        function loadNodeStatus(obj)
            Nodes = NodeStatusComputer(obj);
            Nodes.compute();
            obj.vl = Nodes.vl;
            obj.vr = Nodes.vr;
        end
        function decomposeStiffnessMatrix(obj)
            DecomposeKG = StiffnessMatrixDecomposer(obj);   
            DecomposeKG.decompose();
            obj.KLL = DecomposeKG.KLL;
            obj.KLR = DecomposeKG.KLR; 
        end
    end
end