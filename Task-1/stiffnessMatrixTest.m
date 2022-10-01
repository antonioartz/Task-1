%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   Stiffness matrix test
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [KG] = stiffnessMatrixTest(KG,KG_old,delta)

error = max(max(abs(KG - KG_old)));

if error < delta
    disp('Stiffness matrix test passed successfully');
else
    error('Stiffness matrices do not coincide');
end