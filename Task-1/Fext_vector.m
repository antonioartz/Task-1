function Fe = Fext_vector(dim,x_nod,Tn,s,l)

    for e = 1:dim.nel
   
    x1 = x_nod(Tn(e,1),1);
    x2 = x_nod(Tn(e,2),1);
    
    le = x2 - x1;
    
    x_m = (x2 + x1)/2;
    
        if x2 <= s.L1/2 
        
            q = l*(0.85 - 0.15*cos(2*pi*x_m/s.L1)) - s.g*(27/5)*s.M/s.L;
            
        elseif (x_m > (s.L1/2 - le/2)) && (x_m < (s.L1/2 + le/2))
            
            q = l*(0.85 - 0.15*cos(2*pi*x_m/s.L1)) - s.g*(27/5)*s.M/s.L;
            
        else
        
            q = l*((s.L^2 - 4*(x_m^2))/(s.L^2 - s.L1^2)) - s.g*(9/20)*s.M/s.L;
    
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
            
        if x2 == s.L2/2
            
            Fe(3,e) = Fe(3,e) - s.Me*s.g/2;
            
        elseif x1 == s.L2/2
            
            Fe(1,e) = Fe(1,e) - s.Me*s.g/2;
            
        elseif (x_m > (s.L2/2 - le/2)) && (x_m < (s.L2/2 + le/2))
            
            Fe(3,e) = Fe(3,e) - s.Me*s.g/2;
            Fe(1,e) = Fe(1,e) - s.Me*s.g/2;
        
        end
    
    end

end



