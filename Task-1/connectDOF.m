function Td = connectDOF(dim,Tn)


for e = 1:dim.nel
    for i = 1:dim.nne
        for j = 1:dim.ni
            
            I = dim.ni*(i-1) + j;
            Td(e,I) = dim.ni*(Tn(e,i) - 1) + j;
            
        end
    end
end
end