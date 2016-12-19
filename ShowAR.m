% Plot the embedding results
% *************************************************
% By Ronen Talmon (20.3.2012)
% *************************************************

%% Plot eigenvalues
Vals

%% Rotate eigenvectors according to ref [10]
theta_phi = atan(0.5 * (Phi(:, 3).' * (Phi(:,1).*Phi(:,1) - Phi(:,2).*Phi(:,2)) ) / ( Phi(:,3).' * (Phi(:,1) .* Phi(:,2)))) / 2;
Phi_1 = Phi(:, 1) * cos(theta_phi) - Phi(:,2) * sin(theta_phi);
Phi_2 = Phi(:, 1) * sin(theta_phi) + Phi(:,2) * cos(theta_phi);

theta_psi = atan(0.5 * (Psi(:, 3).' * (Psi(:,1).*Psi(:,1) - Psi(:,2).*Psi(:,2)) ) / ( Psi(:,3).' * (Psi(:,1) .* Psi(:,2)))) / 2;
Psi_1 = Psi(:, 1) * cos(theta_psi) - Psi(:,2) * sin(theta_psi);
Psi_2 = Psi(:, 1) * sin(theta_psi) + Psi(:,2) * cos(theta_psi);

%% Show scatter plots
figure; scatter(Phi_1, Phi_2, 25, LPC_pole_1(subidx), 'fill');
xlabel('$\varphi_1$', 'interpreter','latex','FontSize',16);
ylabel('$\varphi_2$', 'interpreter','latex','FontSize',16);

figure; scatter(Phi_1, Phi_2, 25, LPC_pole_2(subidx), 'fill');
xlabel('$\varphi_1$', 'interpreter','latex','FontSize',16);
ylabel('$\varphi_2$', 'interpreter','latex','FontSize',16);

figure; scatter(Psi_1, Psi_2, 25, LPC_pole_1(:), 'fill');
xlabel('$\psi_1$', 'interpreter','latex','FontSize',16);
ylabel('$\psi_2$', 'interpreter','latex','FontSize',16);

figure; scatter(Psi_1, Psi_2, 25, LPC_pole_2(:), 'fill');
xlabel('$\psi_1$', 'interpreter','latex','FontSize',16);
ylabel('$\psi_2$', 'interpreter','latex','FontSize',16);
