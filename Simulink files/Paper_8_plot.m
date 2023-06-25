clc;
clear;

color_m=[[0.4660, 0.6740, 0.1880]; [0, 0.4470, 0.7410]; [0.9290, 0.6940, 0.1250]; [0.25, 0.25, 0.25]; [0.4940, 0.1840, 0.5560]; [0.6350, 0.0780, 0.1840]];

%% Time trigger + estimator
load("V1.mat");

ref_x = dilute_data(out.ref_x1,10);
time = dilute_data(out.tout, 10);

delta_x_1 = dilute_data(out.delta_x, 10);
u_1 = dilute_data(out.u, 10);
w_tilde_norm_1 = dilute_data(out.w_tilde_norm, 10);
x_tilde_norm_1 = dilute_data(out.x_tilde_norm, 10); 
delta_x_norm_1 = dilute_data(out.delta_x_norm, 10);
x_1 = dilute_data(out.x, 10);

%% Time trigger + ESO
load("V2.mat");

delta_x_2 = dilute_data(out.delta_x, 10);
u_2 = dilute_data(out.u, 10);
w_tilde_norm_2 = dilute_data(out.w_tilde_norm, 10);
x_tilde_norm_2 = dilute_data(out.x_tilde_norm, 10); 
delta_x_norm_2 = dilute_data(out.delta_x_norm, 10);
x_2 = dilute_data(out.x, 10);


%% Event trigger estimator
load("V3.mat");

delta_x_3 = dilute_data(out.delta_x, 10);
u_3 = dilute_data(out.u, 10);
w_tilde_norm_3 = dilute_data(out.w_tilde_norm, 10);
x_tilde_norm_3 = dilute_data(out.x_tilde_norm, 10); 
delta_x_norm_3 = dilute_data(out.delta_x_norm, 10);
x_3 = dilute_data(out.x, 10);

scale = 1;
time_trigger = dilute_data(out.tout, scale);
beta_trigger_3 = dilute_data(structure_to_array(out.beta_trigger), scale);
trigger_flag_3 = dilute_data(out.trigger_flag, scale);
trigger_num_3 = dilute_data(out.trigger_num, scale);
trigger_threshold_3 = dilute_data(structure_to_array(out.trigger_threshold), scale);
E_x_norm_3 = dilute_data(out.trigger_threshold.signals(2).values, scale);
beta_sat_3 = dilute_data(structure_to_array(out.beta_sat), 10);
beta_sat_norm_3 = sqrt(beta_sat_3(:,1).^2+beta_sat_3(:,2).^2+beta_sat_3(:,3).^2);


%% Event trigger + ESO
load("V4.mat");

delta_x_4 = dilute_data(out.delta_x, 10);
u_4 = dilute_data(out.u, 10);
w_tilde_norm_4 = dilute_data(out.w_tilde_norm, 10);
x_tilde_norm_4 = dilute_data(out.x_tilde_norm, 10); 
delta_x_norm_4 = dilute_data(out.delta_x_norm, 10);
x_4 = dilute_data(out.x, 10);

beta_trigger_4 = dilute_data(structure_to_array(out.beta_trigger), scale);
trigger_flag_4 = dilute_data(out.trigger_flag, scale);
trigger_num_4 = dilute_data(out.trigger_num, scale);
trigger_threshold_4 = dilute_data(structure_to_array(out.trigger_threshold), scale);
E_x_norm_4 = dilute_data(out.trigger_threshold.signals(2).values, scale);
beta_sat_4 = dilute_data(structure_to_array(out.beta_sat), 10);
beta_sat_norm_4 = sqrt(beta_sat_4(:,1).^2+beta_sat_4(:,2).^2+beta_sat_4(:,3).^2);

%% Time to plot

%% x_tilde_norm
figure(1)
set(gcf,'Position',[-100,-200,700,1400]);
subplot(3,1,1)
hold on;
grid on;
box on;
plot(time,x_tilde_norm_1(:,2),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time,x_tilde_norm_2(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time,x_tilde_norm_3(:,2),'-','color',color_m(3,:), 'linewidth', 1.5);
plot(time,x_tilde_norm_4(:,2),'--','color',color_m(4,:), 'linewidth', 1.5);
ylim([0, 0.04]);
yticks([0:0.01:0.04]);
set(gca,'FontSize',16);
set(gca,'FontName','times');
xlabel('Time (Second)','FontSize',16);
ylabel('$\|\widetilde{x}\|$','FontSize',16,'interpreter','latex');
% legend('TTEBC','TTOBC','ETEBC','ETOBC','fontsize',16,'Orientation','horizontal','POsition',[0.14,0.9517,0.7502,0.0372]);


subplot(3,1,2)
hold on;
grid on;
box on;
plot(time,w_tilde_norm_1(:,2),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time,w_tilde_norm_2(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time,w_tilde_norm_3(:,2),'-','color',color_m(3,:), 'linewidth', 1.5);
plot(time,w_tilde_norm_4(:,2),'--','color',color_m(4,:), 'linewidth', 1.5);
set(gca,'FontSize',16);
set(gca,'FontName','times');
ylim([0, 0.12]);
yticks([0 0.04 0.08 0.12]);
xlabel('Time (Second)','FontSize',16);
ylabel('$\|\widetilde{w}\|$','FontSize',16,'interpreter','latex');

axes('Position',[0.26,0.502522704339052,0.518333333333333,0.100908173562059]);
grid on;
box on;
hold on;
set(gca,'FontSize',13);
set(gca,'FontName','times');
plot(time,w_tilde_norm_1(:,2),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time,w_tilde_norm_2(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time,w_tilde_norm_3(:,2),'-','color',color_m(3,:), 'linewidth', 1.5);
plot(time,w_tilde_norm_4(:,2),'--','color',color_m(4,:), 'linewidth', 1.5);
xlim([40 60]);
ylim([0 0.024]);
yticks([0 0.006 0.012 0.018 0.024]);

subplot(3,1,3)
hold on;
grid on;
box on;
plot(time,delta_x_norm_1(:,2),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time,delta_x_norm_2(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time,delta_x_norm_3(:,2),'-','color',color_m(3,:), 'linewidth', 1.5);
plot(time,delta_x_norm_4(:,2),'--','color',color_m(4,:), 'linewidth', 1.5);
set(gca,'FontSize',16);
set(gca,'FontName','times');
ylim([0, 1.2]);
yticks([0:0.3:1.2]);
xlabel('Time (Second)','FontSize',16);
ylabel('$\|\delta_x\|$','FontSize',16,'interpreter','latex');
legend('TTEBC','TTOBC','ETEBC','ETOBC','fontsize',16,'Orientation','horizontal','POsition',[0.14,0.9517,0.702,0.02]);

axes('Position',[0.258666666666667,0.187941473259334,0.519,0.109737638748739]);
grid on;
box on;
hold on;
set(gca,'FontSize',13);
set(gca,'FontName','times');
plot(time,delta_x_norm_1(:,2),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time,delta_x_norm_2(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time,delta_x_norm_3(:,2),'-','color',color_m(3,:), 'linewidth', 1.5);
plot(time,delta_x_norm_4(:,2),'--','color',color_m(4,:), 'linewidth', 1.5);
xlim([40 60]);
ylim([0 0.015]);
yticks([0 0.005 0.01 0.015]);


%% Trigger time and event numbers
reu_3 =[];
prev_event = 1;
% First, some data processing
step_length = 0.008;
for i = 2 : size(time_trigger,1)
    if trigger_flag_3(i,2) == 1
        temp = [(i-1)*step_length,(i - prev_event)*step_length*1000];
        reu_3 = [reu_3;temp];
        prev_event = i;
    end
end

reu_4 =[];
prev_event = 1;
% First, some data processing
step_length = 0.008;
for i = 2 : size(time_trigger,1)
    if trigger_flag_4(i,2) == 1
        temp = [(i-1)*step_length,(i - prev_event)*step_length*1000];
        reu_4 = [reu_4;temp];
        prev_event = i;
    end
end

% Then, we plot
figure(2)
set(gcf,'Position',[-100,-200,700,1400]);
subplot(3,1,1)
hold on;
grid on;
box on;
plot([0,60],[step_length*1000,step_length*1000],'--','color',color_m(3,:));
for i = 1:size(reu_3,1)
    plot(reu_3(i,1),reu_3(i,2),'*','color',color_m(1,:));
end
set(gca,'FontSize',16);
set(gca,'FontName','times');
ylim([0 330]);
yticks(0:110:330);
xlabel('Time (Second)','FontSize',16);
ylabel('Trigger interval (ms)','FontSize',16,'interpreter','latex');
legend('Time-triggered (8ms)','ETEBC','fontsize',16,'Orientation','horizontal');

subplot(3,1,2)
hold on;
grid on;
box on;
plot([0,60],[step_length*1000,step_length*1000],'--','color',color_m(3,:));
for i = 1:size(reu_4,1)
    plot(reu_4(i,1),reu_4(i,2),'*','color',color_m(2,:));
end
set(gca,'FontSize',16);
set(gca,'FontName','times');
xlabel('Time (Second)','FontSize',16);
ylim([0 330]);
yticks(0:110:330);
ylabel('Trigger interval (ms)','FontSize',16,'interpreter','latex');
legend('Time-triggered (8ms)','ETOBC','fontsize',16,'Orientation','horizontal');


subplot(3,1,3)
hold on;
grid on;
box on;
plot(dilute_data(time_trigger,10),dilute_data(trigger_num_3(:,2),10),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(dilute_data(time_trigger,10),dilute_data(trigger_num_4(:,2),10),'-.','color',color_m(2,:), 'linewidth', 1.5);
set(gca,'FontSize',16);
set(gca,'FontName','times');
xlabel('Time (Second)','FontSize',16);
ylabel('Event number','FontSize',16);
ylim([0 500]);
yticks(0:100:500);
legend('ETEBC','ETOBC','fontsize',16,'Orientation','horizontal');

axes('Position',[0.572571428571429,0.164434914228052,0.293714285714286,0.0686175580222]);
grid on;
box on;
hold on;
set(gca,'FontSize',13);
set(gca,'FontName','times');
plot(dilute_data(time_trigger,2),dilute_data(trigger_num_3(:,2),2),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(dilute_data(time_trigger,2),dilute_data(trigger_num_4(:,2),2),'-.','color',color_m(2,:), 'linewidth', 1.5);
set(gca,'FontSize',13);
set(gca,'FontName','times');
xlim([59 60]);





%% Trigger thresholds
figure(3)
set(gcf,'Position',[-100,-200,700,1400]);
subplot(2,1,1)
hold on;
grid on;
box on;
set(gca,'FontName','times');
set(gca,'FontSize',16);
plot(time_trigger,trigger_threshold_3(:,1),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time_trigger,trigger_threshold_3(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time_trigger,trigger_threshold_3(:,3),'--','color',color_m(3,:), 'linewidth', 1.5);
plot(time_trigger,E_x_norm_3,'-','color',color_m(4,:), 'linewidth', 1.5);
ylim([-1.6 0.4]);
yticks(-1.6:0.4:0.4);
xlabel('Time (Second)','FontSize',16);
ylabel('Vector norm','FontSize',16);
legend('$F_2 - \alpha_2 \beta_{\rm est}$','$F_3 - \alpha_3 \beta_{\rm con}$','$F_4$','$\|E_x\|$','fontsize',16,'Orientation','horizontal','POsition',[0.14,0.9517,0.702,0.02],'interpreter','latex');
title("ETEBC");


axes('Position',[0.259428571428571,0.641775983854692,0.518571428571429,0.161453077699294]);
grid on;
box on;
hold on;
set(gca,'FontSize',13);
set(gca,'FontName','times');
plot(time_trigger,trigger_threshold_3(:,1),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time_trigger,trigger_threshold_3(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time_trigger,trigger_threshold_3(:,3),'--','color',color_m(3,:), 'linewidth', 1.5);
plot(time_trigger,E_x_norm_3,'-','color',color_m(4,:), 'linewidth', 1.5);
xlim([50 60]);
ylim([0 0.05]);
yticks(0:0.01:0.05);


subplot(2,1,2)
hold on;
grid on;
box on;
set(gca,'FontName','times');
set(gca,'FontSize',16);
plot(time_trigger,trigger_threshold_4(:,1),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time_trigger,trigger_threshold_4(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time_trigger,trigger_threshold_4(:,3),'--','color',color_m(3,:), 'linewidth', 1.5);
plot(time_trigger,E_x_norm_4,'-','color',color_m(4,:), 'linewidth', 1.5);
ylim([-1.6 0.4]);
yticks(-1.6:0.4:0.4);
xlabel('Time (Second)','FontSize',16);
ylabel('Vector norm','FontSize',16);
legend('$F_1 - \alpha_1 \beta_{\rm eso}$','$F_3 - \alpha_3 \beta_{\rm con}$','$F_4$','$\|E_x\|$','fontsize',16,'Orientation','horizontal','POsition',[0.14,0.4717,0.702,0.02],'interpreter','latex');
title("ETOBC");

axes('Position',[0.259428571428571,0.141775983854692,0.518571428571429,0.161453077699294]);
grid on;
box on;
hold on;
set(gca,'FontSize',13);
set(gca,'FontName','times');
plot(time_trigger,trigger_threshold_4(:,1),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time_trigger,trigger_threshold_4(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time_trigger,trigger_threshold_4(:,3),'--','color',color_m(3,:), 'linewidth', 1.5);
plot(time_trigger,E_x_norm_4,'-','color',color_m(4,:), 'linewidth', 1.5);
xlim([50 60]);
ylim([0 0.05]);
yticks(0:0.01:0.05);


%% Tracking trajectory
figure(4)
set(gcf,'Position',[-50,-50,500,600]);
grid on;
box on;
hold on;
set(gca,'FontSize',13);
set(gca,'FontName','times');
plot(x_3(:,2),x_3(:,3),'-','color',color_m(1,:), 'linewidth', 1.5);
plot(ref_x(:,2),ref_x(:,3),'-.','color',color_m(2,:), 'linewidth', 1.5);
xlabel('X (m)','FontSize',16);
ylabel('Y (m)','FontSize',16);
legend('ETEBC (Simulation)','Reference','fontsize',16,'Orientation','horizontal');


%% Convergence of beta
figure(5)
set(gcf,'Position',[-100,-200,1100,500]);
grid on;
box on;
hold on;
subplot(1,2,1)
hold on;
grid on;
box on;
set(gca,'FontName','times');
set(gca,'FontSize',16);
plot(time_trigger,beta_trigger_3(:,1),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time_trigger,beta_trigger_3(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time,beta_sat_norm_3,'--','color',color_m(3,:), 'linewidth', 1.5);
% ylim([-1.8 0.2]);
% yticks(-1.8:0.2:0.2);
xlabel('Time (Second)','FontSize',16);
ylabel('Vector norm','FontSize',16);
legend('$\beta_{\rm est}$','$\beta_{\rm con}$','$\|\beta_{\rm sat}\|$','fontsize',16,'Orientation','horizontal','interpreter','latex');
title("ETEBC");

subplot(1,2,2)
hold on;
grid on;
box on;
set(gca,'FontName','times');
set(gca,'FontSize',16);
plot(time_trigger,beta_trigger_4(:,1),'--','color',color_m(1,:), 'linewidth', 1.5);
plot(time_trigger,beta_trigger_4(:,2),'-.','color',color_m(2,:), 'linewidth', 1.5);
plot(time,beta_sat_norm_4,'--','color',color_m(3,:), 'linewidth', 1.5);
% ylim([-1.8 0.2]);
% yticks(-1.8:0.2:0.2);
xlabel('Time (Second)','FontSize',16);
ylabel('Vector norm','FontSize',16);
legend('$\beta_{\rm eso}$','$\beta_{\rm con}$','$\|\beta_{\rm sat}\|$','fontsize',16,'Orientation','horizontal','interpreter','latex');
title("ETOBC");

%% Convergence region
clc

time_start = 40;
time_end = 60;
step = 0.08;

% max(x_tilde_norm_1(time_start/step:time_end/step,2))
% max(x_tilde_norm_2(time_start/step:time_end/step,2))
% max(x_tilde_norm_3(time_start/step:time_end/step,2))
% max(x_tilde_norm_4(time_start/step:time_end/step,2))
% 
% max(w_tilde_norm_1(time_start/step:time_end/step,2))
% max(w_tilde_norm_2(time_start/step:time_end/step,2))
% max(w_tilde_norm_3(time_start/step:time_end/step,2))
% max(w_tilde_norm_4(time_start/step:time_end/step,2))

max(delta_x_norm_1(time_start/step:time_end/step,2))
max(delta_x_norm_2(time_start/step:time_end/step,2))
max(delta_x_norm_3(time_start/step:time_end/step,2))
max(delta_x_norm_4(time_start/step:time_end/step,2))

step = 0.008;
% max(E_x_norm_3(time_start/step:time_end/step))
% max(E_x_norm_4(time_start/step:time_end/step))
