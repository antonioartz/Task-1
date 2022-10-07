classdef forceVectorTest < TestComputer

properties (Access = public)
loadedData
end

methods (Access = public)
    function loadedData(obj)
        load('stiffMatrix.mat','Fext');
        loadedData = Fext;
    end
end

methods(Access = public)
    function obj = forceVectorTest(cParams)
        obj.init(cParams);
    end
end