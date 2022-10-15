function [x_cdm,y_cdm,I_xb,I_yb,Ab] = inertia(beamDiv, elem_dim,N)

   % mass center 
   num_xcdm = 0;
   den_xcdm = 0;
   num_ycdm = 0;
   den_ycdm = 0;
   
   for i = 1:N
       area(i,1) = beamDiv(i,3)*beamDiv(i,4);
   end
   
   for i = 1:N
      num_xcdm = num_xcdm + (area(i,1)*beamDiv(i,1));
      den_xcdm = den_xcdm + area(i,1);
      
      num_ycdm = num_ycdm + (area(i,1)*beamDiv(i,2));
      den_ycdm = den_ycdm + area(i,1);
      
   end
   x_cdm = num_xcdm/den_xcdm;
   y_cdm = num_ycdm/den_ycdm;
   
   Ab = den_xcdm;
   
   % Inertia
   I_xb = 0; % this value will be updated
   I_yb = 0; % this value will be uptated
   
   
   for i = 1:N
      Ix(i,1) = area(i,1)*(y_cdm - beamDiv(i,2))^2 + (1/12)*elem_dim(i,1)*elem_dim(i,2)^3;
      Iy(i,1) = area(i,1)*(x_cdm - beamDiv(i,1))^2 + (1/12)*elem_dim(i,2)*elem_dim(i,1)^3;
      
      I_xb = I_xb + Ix(i,1);
      I_yb = I_yb + Iy(i,1);
   end
   end