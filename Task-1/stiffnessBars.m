function Kel = stiffnessBars(dim,x_nod,Tn,mat,Tmat)

    for e = 1:dim.nel
    
    E = mat(Tmat(e),1);
    I = mat(Tmat(e),2);
 

    x1 = x_nod(Tn(e,1),1);
    x2 = x_nod(Tn(e,2),1);
    
    le = x2 - x1;
    
    R = (1/le)*[
      x2 - x1, 0,       0, 0;
            0, le,       0, 0;
            0, 0, x2 - x1, 0;
            0, 0,       0, le;
    ];

        
    Rp = R.';

    Kep_1 = ((E*I)/le^3)*[   
             12,   6*le,  -12,   6*le;
            6*le, 4*le^2, -6*le, 2*le^2;
            -12,  -6*le,   12,  -6*le;
            6*le, 2*le^2, -6*le, 4*le^2;
        ];



    Kep = Kep_1;
    
    Kel(:,:,e) =  Rp*Kep*R ;   
    
    end 
end
