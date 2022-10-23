classdef InertiaComputer < handle

   properties (Access = public)
      x_cdm,y_cdm
      Ixb,Iyb
      Ab
   end
   properties (Access = private)
      beamDiv
      elem_dim
      N
   end

   methods (Access = public)
      function obj = InertiaComputer(cParams)
         obj.init(cParams);
      end
      function compute(obj)
         obj.computeInertia();
      end
   end

   methods (Access = private)
         function init(obj,cParams)
            obj.beamDiv = cParams.beamDiv;
            obj.elem_dim = cParams.elem_dim;
            obj.N = cParams.N;
         end
         function computeInertia(obj)
            % mass center 
            num_xcdm = 0;
            den_xcdm = 0;
            num_ycdm = 0;
            den_ycdm = 0;
            
            for i = 1:obj.N
               area(i,1) = obj.beamDiv(i,3)*obj.beamDiv(i,4);
            end
            
            for i = 1:obj.N
               num_xcdm = num_xcdm + (area(i,1)*obj.beamDiv(i,1));
               den_xcdm = den_xcdm + area(i,1);
               
               num_ycdm = num_ycdm + (area(i,1)*obj.beamDiv(i,2));
               den_ycdm = den_ycdm + area(i,1);
               
            end
            obj.x_cdm = num_xcdm/den_xcdm;
            obj.y_cdm = num_ycdm/den_ycdm;
            
            obj.Ab = den_xcdm;
            
            % Inertia
            I_xb = 0; % this value will be updated
            I_yb = 0; % this value will be uptated
            
            
            for i = 1:obj.N
               Ix(i,1) = area(i,1)*(obj.y_cdm - obj.beamDiv(i,2))^2 + (1/12)*obj.elem_dim(i,1)*obj.elem_dim(i,2)^3;
               Iy(i,1) = area(i,1)*(obj.x_cdm - obj.beamDiv(i,1))^2 + (1/12)*obj.elem_dim(i,2)*obj.elem_dim(i,1)^3;
               
               I_xb = I_xb + Ix(i,1);
               I_yb = I_yb + Iy(i,1);
            end
            obj.Ixb = I_xb;
            obj.Iyb = I_yb;
         end
   end
end