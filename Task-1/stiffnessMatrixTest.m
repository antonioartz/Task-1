classdef stiffnessMatrixTest < TestComputer

properties (Access = public)
loadedData
end

methods (Access = public)
    function loadedData(obj)
        load('stiffMatrix.mat','KG');
        loadedData = KG;
    end
end

methods(Access = public)
    function obj = stiffnessMatrixTest(cParams)
        obj.init(cParams);
    end
end