function [x_cdm,y_cdm,Ixx,Iyy] = inertia(beamDiv, elem_dim,N)

% mass center 
num_xcdm = 0;       % this value will be updated
den_xcdm = 0;       % this value will be updated
num_ycdm = 0;       % this value will be updated
den_ycdm = 0;       % this value will be updated


    area(:,1) = beamDiv(:,3).*beamDiv(:,4);


for i = 1:N
   num_xcdm = num_xcdm + (area(i,1)*beamDiv(i,1));
   den_xcdm = den_xcdm + area(i,1);
   
   num_ycdm = num_ycdm + (area(i,1)*beamDiv(i,2));
   den_ycdm = den_ycdm + area(i,1);
   
end
x_cdm = num_xcdm/den_xcdm;
y_cdm = num_ycdm/den_ycdm;

% Inertia
Ixx = 0;            % this value will be updated
Iyy = 0;            % this value will be updated


for i = 1:N
   Ix(i,1) = area(i,1)*(y_cdm - beamDiv(i,2))^2 + (1/12)*elem_dim(i,1)*elem_dim(i,2)^3;
   Iy(i,1) = area(i,1)*(x_cdm - beamDiv(i,1))^2 + (1/12)*elem_dim(i,2)*elem_dim(i,1)^3;
   
   Ixx = Ixx + Ix(i,1);
   Iyy = Iyy + Iy(i,1);
end
end