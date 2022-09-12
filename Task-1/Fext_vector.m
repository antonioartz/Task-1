function Fe = Fext_vector(dim,x_nod,Tn,L1,L2,l,g,Me,M,L)

    for e = 1:dim.nel
   
    x1 = x_nod(Tn(e,1),1);
    x2 = x_nod(Tn(e,2),1);
    
    le = x2 - x1;
    
    x_m = (x2 + x1)/2;
    
        if x2 <= L1/2 
        
            q = l*(0.85 - 0.15*cos(2*pi*x_m/L1)) - g*(27/5)*M/L;
            
        elseif (x_m > (L1/2 - le/2)) && (x_m < (L1/2 + le/2))
            
            q = l*(0.85 - 0.15*cos(2*pi*x_m/L1)) - g*(27/5)*M/L;
            
        else
        
            q = l*((L^2 - 4*(x_m^2))/(L^2 - L1^2)) - g*(9/20)*M/L;
    
        end
       
    R = (1/le)*[
      x2 - x1, 0, 0, 0;
      0, le, 0, 0;
      0, 0, x2 - x1, 0;
      0, 0, 0, le;
    ];

    Rp = R.';

    Fep = (q*le/2)*[
        1; le/6; 1; -le/6; 
    ];
        
    Fe(:,e) = Rp*Fep;
            
        if x2 == L2/2
            
            Fe(3,e) = Fe(3,e) - Me*g/2;
            
        elseif x1 == L2/2
            
            Fe(1,e) = Fe(1,e) - Me*g/2;
            
        elseif (x_m > (L2/2 - le/2)) && (x_m < (L2/2 + le/2))
            
            Fe(3,e) = Fe(3,e) - Me*g/2;
            Fe(1,e) = Fe(1,e) - Me*g/2;
        
        end
    
    end

end



