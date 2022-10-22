classdef DisplacementsTest < TestComputer

    methods (Access = private)
        function loadData(obj)
            load('displacementsData.mat','u');
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
