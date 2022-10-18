function Td = connectDOF(s)

for e = 1:s.dim.nel
    for i = 1:s.dim.nne
        for j = 1:s.dim.ni

            I = s.dim.ni*(i-1) + j;
            Td(e,I) = s.dim.ni*(s.data.Tn(e,i) - 1) + j;

        end
    end
end
end