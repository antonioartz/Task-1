function plotMax_U_Mz(max_u,max_Mz,N_discr)

figure;
subplot(2,1,1)
semilogx(N_discr,max_u,'-d')
xlabel('N$^\circ$ of discretizations','Interpreter','latex');
ylabel('$u_{y\; max}$ [m]','Interpreter','latex');
title('\textbf{Maximum displacement per discretization}','Interpreter','latex');
box on;
grid on;

subplot(2,1,2)
semilogx(N_discr,max_Mz,'-d')
xlabel('N$^\circ$ of discretizations','Interpreter','latex');
ylabel('$M_{z\; max}$ [Nm]','Interpreter','latex');
title('\textbf{Maximum bending moment per discretization}','Interpreter','latex');
box on;
grid on;

end