function plotMax_U_Mz(max_u,max_Mz,N_discr)

figure;
subplot(2,1,1)
semilogx(N_discr,max_u,'-d')
xlabel('Nº of discretizations');
ylabel('u_{y max} [m]');
title('Maximum displacement per discretization');
box on;
grid on;

subplot(2,1,2)
semilogx(N_discr,max_Mz,'-d')
xlabel('Nº of discretizations');
ylabel('M_{z max} [Nm]');
title('Maximum bending moment per discretization');
box on;
grid on;

end