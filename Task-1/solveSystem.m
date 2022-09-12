function [u,R,vl,vr,ur] = solveSystem(dim,KG,Fext,fixNod)

vr = zeros(size(fixNod,1),1);
 
 for i = 1:size(fixNod,1)
      
     vr(i,1) = dim.ni*(fixNod(i,1) - 1 ) + fixNod(i,2);
     
 end

ur(:,1) = fixNod(:,3);

vl = [1:dim.ndof]';
vl(vr) = [];

KLL = KG(vl,vl);
KLR = KG(vl,vr);
KRL = KG(vr,vl);
KRR = KG(vr,vr);
FL = Fext(vl,1);
FR = Fext(vr,1);

ul = KLL\(FL - KLR*ur);
R = KRR*ur + KRL*ul - FR;

u(vl,1) = ul;
u(vr,1) = ur;

end