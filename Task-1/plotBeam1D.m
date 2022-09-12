function [max_displ,max_bend,u_e] = plotBeam1D(x_nod,Puy,Ptz,Fy,Mz,Tn,N_elem,fig)

x_e = zeros(N_elem + 1,size(Tn,1));
u_e = zeros(N_elem + 1,size(Tn,1));
theta_e = zeros(N_elem + 1,size(Tn,1)); 
Fy_e = Fy';
Mz_e = Mz';
xe = x_nod(Tn)';

for e = 1:size(Tn,1)
   
    le = x_nod(Tn(e,2)) - x_nod(Tn(e,1));
    x_e(:,e) = x_nod(Tn(e,1)) + (0:le/N_elem:le);
    u_e(:,e) = polyval(Puy(e,:), 0:le/N_elem:le);
    theta_e(:,e) = polyval(Ptz(e,:), 0:le/N_elem:le);
    
end

max_displ = u_e(1,1);

for i = length(u_e(:,1))
    
    for j = length(u_e(1,:))
        
        if max_displ < u_e(i,j)
            
            max_displ = u_e(i,j);
            
        end
    end
end

max_bend_1 = max(Mz(:,1));
max_bend_2 = max(Mz(:,2));

if max_bend_1 < max_bend_2
    
    max_bend = max_bend_2;
    
else
    
    max_bend = max_bend_1;
    
end
    

figure(fig)
% Plot beam deflection
subplot(2,2,1)
plot(x_e(:),u_e(:)); 


% Plot beam section rotation
subplot(2,2,2)
plot(x_e(:),theta_e(:));


% Plot beam internal shear force
subplot(2,2,3)
plot(xe(:),Fy_e(:));


% Plot beam internal bending moment
subplot(2,2,4)
plot(xe(:),Mz_e(:));

end
