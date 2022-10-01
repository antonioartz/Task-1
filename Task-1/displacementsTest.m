%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   Displacements test
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [u] = displacementsTest(u,u_old,delta)

error = max(max(abs(u - u_old)));

if error < delta
    disp('Displacements test passed successfully');
else
    error('Displacements vectors do not coincide');
end