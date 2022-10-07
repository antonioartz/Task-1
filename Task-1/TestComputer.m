classdef TestComputer < handle

[KG,Fext,u,tolerance] = main_function(s);

properties (Access = public)
KG
Fext
u
tolerance
end

methods (Access = public)
    function obj = TestComputer(cParams)
    end

    function [loadedData, actualData] = testSelector(obj)
        switch obj.desiredTest
        case{'StiffnessMatrix'}
            obj.actualData = obj.KG;
            stiffnessMatrixTest(obj);
        case{'ForceVector'}
            obj.actualData = obj.Fext;
            forceVectorTest(obj);
        case{'Displacements'}
            obj.actualData = u;
            displacementsTest(obj);
        otherwise
            error('Invalid solver type')
    end

end

methods (Access = protected)
    function result(obj)
        switch pass
            case{1}
                fprintf(obj.desiredTest); fprintf('test passed \n');
            case{0}
                fprintf(obj.desiredTest); fprintf('test failed \n');
        end
    end

    function init(obj,cParams)
        obj.KG = cParams.KG;
        obj.Fext = cParams.Fext;
        obj.u = cParams.u;
        obj.tolerance = cParams.tolerance;
    end
end

methods (Access = private)
    function pass = check(obj)
        maxDifference = obj.computeMaxDifference();
        if maxDifference > tolerance
            pass = 0;
        else
            pass = 1;
        end
    end

    function maxDifference = computeMaxDifference(obj)
        difference = obj.computeDifference();
        maxDifference = max(max(difference));
    end

    function difference = computeDifference(obj)
        difference = abs(obj.actualData - obj.loadedData);
    end
end