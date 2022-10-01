%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   Force vector test
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Fext] = forceVectorTest(Fext,Fext_old,delta)

error = max(max(abs(Fext - Fext_old)));

if error < delta
    disp('Force vector test passed successfully');
else
    error('Force vectors do not coincide');
end