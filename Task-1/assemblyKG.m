function [KG,Fext] = assemblyKG(dim,Td,Kel,Fe)
% Testing commit on changes
% More testing, this time branch testing
KG = zeros(dim.ndof,dim.ndof);
Fext = zeros(dim.ndof,1);

    for e = 1:dim.nel
        
        for i = 1:dim.nne*dim.ni
            
            I = Td(e,i);
            Fext(I,1) = Fext(I,1) + Fe(i,e);
            
            for j = 1:dim.nne*dim.ni
                
                J = Td(e,j);
                KG(I,J) = KG(I,J) + Kel(i,j,e);
            
            end
            
        end
    end
end

