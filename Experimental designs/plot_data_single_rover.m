%% Color matrix for plotiing data
color_m=[[0.4660, 0.6740, 0.1880]; [0, 0.4470, 0.7410]; [0.9290, 0.6940, 0.1250]; [0.25, 0.25, 0.25]; [0.4940, 0.1840, 0.5560]; [0.6350, 0.0780, 0.1840]];

%% Load the dataset you want to check
load('V1.mat');

%% Some basic parameters
total_time = 60;
time_step = 0.008;

length = total_time/time_step + 1;

%% Processing
x_tilde = agent_pos - x_hat;
x_tilde_norm = sqrt(x_tilde(:,1).^2 + x_tilde(:,2).^2 + x_tilde(:,3).^2);
delta_norm = sqrt(delta_x(:,1).^2 + delta_x(:,2).^2 + delta_x(:,3).^2);
beta_sat_norm = sqrt(beta_sat(:,1).^2 + beta_sat(:,2).^2 + beta_sat(:,3).^2);

%% Tracking error
figure(1)
hold on;
grid on;
box on;
set(gcf, 'Position', [100,100,800,400]);
plot(time_matrix(1:length), x_tilde_norm, '--', 'color',color_m(1, :), 'linewidth', 2);
plot(time_matrix(1:length), delta_norm, '-', 'color',color_m(2, :), 'linewidth', 2);
plot(time_matrix(1:length), beta_sat_norm, '-.', 'color',color_m(3, :), 'linewidth', 2);
xlim([0 60]);
set(gca,'FontSize',18);
set(gca,'fontname','times');
xlabel('Time (Second)','FontSize',18);
ylabel('Vector norm','FontSize',18);

legend("$\|\widetilde{x}\|$","$\|\delta_x\|$","$\|\beta_{\rm sat}\|$",'fontsize',18,'Orientation','horizontal','interpreter','latex');

axes('Position',[0.26,0.415,0.51625,0.3475]);
hold on;
grid on;
box on;
set(gca,'FontSize',14);
set(gca, 'fontname', 'times');
% ylim([0 0.008]);
% yticks(0:0.004:0.008);
xlim([40 60]);

plot(time_matrix(1:length), x_tilde_norm, '--', 'color',color_m(1, :), 'linewidth', 2);
plot(time_matrix(1:length), delta_norm, '-', 'color',color_m(2, :), 'linewidth', 2);
plot(time_matrix(1:length), beta_sat_norm, '-.', 'color',color_m(3, :), 'linewidth', 2);

%% Event trigger threshold and observation error
figure(2)
hold on; 
grid on;
box on;
set(gcf, 'Position', [100,100,800,400]);
plot(time_matrix, E_norm, '-', 'color',color_m(1, :), 'linewidth', 1.5);
plot(time_matrix, trigger_bound(:,1), '--', 'color',color_m(2, :), 'linewidth', 1);
plot(time_matrix, trigger_bound(:,2), '-.', 'color',color_m(3, :), 'linewidth', 1);
plot(time_matrix, trigger_bound(:,3), '-.', 'color',color_m(4, :), 'linewidth', 1);
xlim([0 60]);
set(gca,'FontSize',18);
set(gca,'fontname','times');
xlabel('Time (Second)','FontSize',18);
ylabel('Function values','FontSize',18);

legend("$\|E_x\|$","$F_2 - \gamma_2 \beta_{\rm est}$","$F_3 - \gamma_2 \beta_{\rm con}$",'$F_4$','fontsize',18,'Orientation','horizontal','interpreter','latex');

axes('Position',[0.22125,0.275,0.51625,0.3475]);
hold on;
grid on;
box on;
set(gca,'FontSize',14);
set(gca, 'fontname', 'times');
ylim([0 0.04]);
% yticks(0:0.004:0.008);
xlim([50 60]);

set(gca,'FontSize',18);
set(gca,'fontname','times');
xlabel('Time (Second)','FontSize',18);
ylabel('Function values','FontSize',18);

plot(time_matrix, E_norm, '-', 'color',color_m(1, :), 'linewidth', 1.5);
plot(time_matrix, trigger_bound(:,1), '--', 'color',color_m(2, :), 'linewidth', 1);
plot(time_matrix, trigger_bound(:,2), '-.', 'color',color_m(3, :), 'linewidth', 1);

%% Trigger interval
prev_trigger = 1;
figure(3)
hold on; 
grid on;
box on;
set(gcf, 'Position', [100,100,1000,400]);
plot([0 60], [8, 8], 'r--');

for i = 2 : size(time_matrix,1)
    if trigger_flag(i) == 1
        interval = (i - prev_trigger) * time_step * 1000;
        plot( (i-1) * time_step, interval, 'b*');
        prev_trigger = i;
    end
end
legend("Time Trigger","Event trigger",'fontsize',18,'Orientation','vertical');

set(gca,'FontSize',18);
set(gca,'fontname','times');
xlabel('Time (Second)','FontSize',18);
ylabel('Trigger interval (ms)','FontSize',18);


%% System trajectory
figure(4)
hold on;
grid on;
box on;
set(gcf, 'Position', [100,100,600,500]);
plot(pos_ref(:,1),pos_ref(:,2),'color', color_m(1,:), 'linewidth', 1.5);
plot(agent_pos(:,1),agent_pos(:,2),'--','color', color_m(2,:), 'linewidth', 2);
set(gca,'FontSize',18);
set(gca,'fontname','times');
xlabel('X (m)','FontSize',18);
ylabel('Y (m)','FontSize',18);

legend("Actual","Expected",'fontsize',18,'Orientation','vertical');

%% Control input
figure(5)
hold on;
grid on;
box on;
set(gcf, 'Position', [100,100,800,400]);
plot(time_matrix, agent_control(:,1), '-', 'color',color_m(1,:), 'linewidth', 2);
plot(time_matrix, agent_control(:,2), '--', 'color',color_m(2,:), 'linewidth', 2);
plot(time_matrix, agent_control(:,3), '-.', 'color',color_m(3,:), 'linewidth', 2);
xlim([0 60]);
set(gca,'FontSize',18);
set(gca,'fontname','times');
xlabel('Time (Second)','FontSize',18);
ylabel('Tracking error','FontSize',18);

plot([0 60], [0.2, 0.2], '--', 'color', color_m(4,:));
plot([0 60], [-0.2, -0.2], '--', 'color', color_m(4,:));

legend("$u(1)$","$u(2)$","$u(3)$",'fontsize',18,'Orientation','horizontal','interpreter','latex');

