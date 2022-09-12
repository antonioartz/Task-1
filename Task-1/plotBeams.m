function fig = plotBeams(L)
% Open figure window
fig = figure('units','centimeters','Position',[6,6,20,20]);

% Plot beam deflection
subplot(2,2,1)
hold on
xlim([0,L/2]);
xlabel('x [m]');
ylabel('u_y [m]');
title('Deflection');
box on;
grid on;

% Plot beam section rotation
subplot(2,2,2)
hold on
xlim([0,L/2]);
xlabel('x [m]');
ylabel('\theta_z [rad]');
title('Rotation');
box on;
grid on;

% Plot beam internal shear force
subplot(2,2,3)
hold on
xlim([0,L/2]);
xlabel('x [m]');
ylabel('F_y [N]');
title('Shear force');
box on;
grid on;

% Plot beam internal bending moment
subplot(2,2,4)
hold on
xlim([0,L/2]);
xlabel('x [m]');
ylabel('M_z [Nm]');
title('Bending moment');
box on;
grid on;

end

