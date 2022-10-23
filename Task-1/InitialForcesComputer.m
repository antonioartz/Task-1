classdef InitialForcesComputer < handle

    properties (Access = public)
        Ny,Nx
        frx,fry
        N,fr
    end
    properties (Access = private)
        v
        alpha
        Io
        r_w
        t_f
        fr_coeff
    end

   methods (Access = public)
       function obj = InitialForcesComputer(cParams)
            obj.init(cParams);
       end
       function compute(obj)
           obj.forcesComputer();
       end
   end
   methods (Access = private)
       function init(obj,cParams)
           obj.v = cParams.v;
           obj.alpha = cParams.alpha;
           obj.Io = cParams.Io;
           obj.r_w = cParams.r_w;
           obj.t_f = cParams.t_f;
           obj.fr_coeff = cParams.fr_coeff;
       end
       function forcesComputer(obj)
           obj.fr = (obj.Io*obj.v/(obj.r_w^2*obj.t_f));
           obj.frx = obj.fr*cos(obj.alpha);
           obj.fry = obj.fr*sin(obj.alpha);
            
           obj.N = (1/obj.fr_coeff)*obj.fr;
           obj.Ny = obj.N*cos(obj.alpha);
           obj.Nx = obj.N*sin(obj.alpha);
       end
   end
end