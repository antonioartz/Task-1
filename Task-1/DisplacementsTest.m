classdef DisplacementsTest < TestComputer

    properties (Access = public)
        loadedData
        actualData
    end

    methods (Access = private)
        function loadData(obj)
            load('displacements.mat','u');
            obj.loadedData = u;
        end
        function storeActualData(obj)
            obj.actualData = obj.u;
        end
    end

    methods(Access = public)
        function obj = DisplacementsTest(cParams)
            obj.init(cParams);
            obj.initParams(cParams);
            obj.loadData();
            obj.storeActualData();
        end
    end
end
