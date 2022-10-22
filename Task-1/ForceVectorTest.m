classdef ForceVectorTest < TestComputer

    methods (Access = private)
        function loadData(obj)
            load('stiffnessMatrixData.mat','Fext');
            obj.loadedData = Fext;
        end
        function storeActualData(obj)
            obj.actualData = obj.Fext;
        end
    end

    methods(Access = public)
        function obj = ForceVectorTest(cParams)
            obj.init(cParams);
            obj.initParams(cParams);
            obj.loadData();
            obj.storeActualData();
        end
    end
end
