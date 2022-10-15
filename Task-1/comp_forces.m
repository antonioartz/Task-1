function [Ny,Nx,frx,fry,N,fr] = comp_forces(v,alpha,Io,r_w,t_f,fr_coeff)

fr = (Io*v/(r_w^2*t_f));
frx = fr*cos(alpha);
fry = fr*sin(alpha);

N = (1/fr_coeff)*fr;
Ny = N*cos(alpha);
Nx = N*sin(alpha);


end

