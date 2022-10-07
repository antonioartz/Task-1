classdef displacementsTest < TestComputer

properties (Access = public)
loadedData
end

methods (Access = public)
    function loadedData(obj)
        load('displacements.mat','u');
        obj.loadedData = u;
    end
end

methods(Access = public)
    function obj = displacementsTest(cParams)
        obj.init(cParams);
    end
end