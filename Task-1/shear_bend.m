function [Fy,Mz,Puy,Ptz] = shear_bend(dim,x_nod,Tn,Td,Kel,u)

Fy = zeros(dim.nel,2);
Mz = zeros(dim.nel,2);

for e = 1:dim.nel

    x1 = x_nod(Tn(e,1),1);
    x2 = x_nod(Tn(e,2),1);
    
    le = x2 - x1;
    
    Re = (1/le)*[
        x2 - x1,  0,       0,  0;
              0, le,       0,  0;
              0,  0, x2 - x1,  0;
              0,  0,       0, le;
    ];

    for i = 1:dim.nne*dim.ni
       
        I = Td(e,i);
        ue(i,1) = u(I,1);
        
    end
    
    uep = Re*ue;
    
    Fint = Kel(:,:,e)*ue;
    Fint_p = Re*Fint;
    
    Fy(e,1) = -Fint_p(dim.ni - 1);
    Fy(e,2) = Fint_p(2*dim.ni - 1);
    
    Mz(e,1) = -Fint_p(dim.ni);
    Mz(e,2) = Fint_p(2*dim.ni);
    
    coeff = (1/le^3)*[
            2,      le,   -2,    le;
        -3*le, -2*le^2, 3*le, -le^2;
            0,    le^3,    0,     0;
         le^3,       0,    0,     0;
    ]*uep;

    a = coeff(1);
    b = coeff(2);
    c = coeff(3);
    d = coeff(4);
    
    Puy(e,[1,2,3,4]) = [a, b, c, d];
    Ptz(e,[1,2,3]) = [3*a, 2*b, c];

end
end