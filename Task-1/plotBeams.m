function fig = plotBeams(L)
% Open figure window
fig = figure('units','centimeters','Position',[6,6,20,20]);

% Plot beam deflection
subplot(2,2,1)
hold on
xlim([0,L/2]);
xlabel('$x$ [m]','Interpreter','latex');
ylabel('$u_y$ [m]','Interpreter','latex');
title('\textbf{Deflection}','Interpreter','latex');
box on;
grid on;

% Plot beam section rotation
subplot(2,2,2)
hold on
xlim([0,L/2]);
xlabel('$x$ [m]','Interpreter','latex');
ylabel('$\theta_z$ [rad]','Interpreter','latex');
title('\textbf{Rotation}','Interpreter','latex');
box on;
grid on;

% Plot beam internal shear force
subplot(2,2,3)
hold on
xlim([0,L/2]);
xlabel('$x$ [m]','Interpreter','latex');
ylabel('$F_y$ [N]','Interpreter','latex');
title('\textbf{Shear force}','Interpreter','latex');
box on;
grid on;

% Plot beam internal bending moment
subplot(2,2,4)
hold on
xlim([0,L/2]);
xlabel('$x$ [m]','Interpreter','latex');
ylabel('$M_z$ [Nm]','Interpreter','latex');
title('\textbf{Bending moment}','Interpreter','latex');
box on;
grid on;

end

