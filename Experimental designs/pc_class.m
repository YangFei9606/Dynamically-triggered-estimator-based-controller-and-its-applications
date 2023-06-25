
%% This file contains the tasks finished by the computer

classdef pc_class < handle
    
    properties
        info_udp = '';
    end

    methods
        
        %% Step 1: UDP communication
        function udp_communication(obj, rover_ip, step_size)

            udp_port = udp(rover_ip, 2390);
            fopen(udp_port);
            % Prepare data
            obj.info_udp = num2str(step_size);

            % Send out multiple times to make sure
            for j = 1 : 20
                fwrite(udp_port,obj.info_udp);
            end

        end

        %% Step 2: Generate reference
        function [pos_ref, vel_ref] = reference_generator(~, current_time, serial_num)

            R_1 = 0.35;
            phase_1 = serial_num * 2 * pi/3;
            w_1 = - pi/13;

            cen_x = 0;
            cen_y = -1 - current_time/60;

            pos_ref = [ R_1 * cos(w_1 * current_time + phase_1) + cen_x; 1.5 * R_1 * sin(w_1 * current_time + phase_1) + cen_y; 0 ];

            vel_ref = [ - R_1 * w_1 * sin(w_1 * current_time + phase_1); 1.5 * R_1 * w_1 * cos(w_1 * current_time + phase_1) - 1/60; 0 ];

        end
        %% Step 3: Uncertainty observer
        function rov_info = uncertainty_observer(~, time_step, rover_R, rov_info)
            eta_1 = diag([21,21,3]);
            eta_2 = 0.7;
            k_1 = diag([3,3,1]);
            
            x_tilde = rov_info.x_i_trigger - rov_info.x_hat_i;
            theta = rov_info.x_i_trigger(3);
            
            rov_info.g_i = [-sin(theta), -sin(pi/3 - theta), sin(pi/3 + theta);
                            cos(theta), -cos(pi/3 - theta), -cos(pi/3 + theta);
                            1/rover_R, 1/rover_R, 1/rover_R];
            
            % Update of adaptive term
            % #1 Adaptive uncertainty estimator
            rov_info.w_hat_i = rov_info.w_hat_i + time_step * (eta_1 * x_tilde - eta_2 * rov_info.w_hat_i);
            % #2 Extended state observer
%             rov_info.w_hat_i = rov_info.w_hat_i + time_step * eta_1 * x_tilde;
            
            % Fictitious control law
            rov_info.u_hat_i = k_1 * x_tilde + rov_info.w_hat_i;
            
            rov_info.x_hat_i = rov_info.x_hat_i + time_step * (rov_info.u_hat_i + rov_info.g_i * rov_info.u_i);
        end

        %% Step 4: Calculate control input (PC acts as controller)
        function rover_info = controller(~, time_step, satu_limit, rover_R, rover_info)
            
            % Parameters for the auxiliary variable
            eta_3 = diag([6,6,1]);
            eta_4 = diag([0.5,0.5,0.2]);

            % Parameters for controller itself
            k_2 = diag([3,3,1.5]);
            k_3 = diag([8,8,2]);
              
            % Reverse of control gain matrix    
            theta_i = rover_info.x_i_trigger(3);
            r_m_inv = [ -2/3 * sin(theta_i),          2/3 * cos(theta_i),         rover_R/3;
                        -2/3 * sin(pi/3 - theta_i),   -2/3 * cos(pi/3 - theta_i), rover_R/3;
                         2/3 * sin(pi/3 + theta_i),   -2/3 * cos(pi/3 + theta_i), rover_R/3];

            % Triggered tracking error
            delta_x = rover_info.x_i_trigger - rover_info.x_di;

            % Virtual communication for local tracking error
            u_nom = r_m_inv * (- k_2 * delta_x + rover_info.v_di - rover_info.w_hat_i - k_3 * rover_info.beta_sat);

            rover_info.u_i = min(max(u_nom, - satu_limit), satu_limit);
            
            u_diff = u_nom - rover_info.u_i;

            beta_M = 0.01;
            
            if norm(rover_info.beta_sat) > beta_M
                rover_info.beta_sat = rover_info.beta_sat + time_step * (eta_3 * rover_info.g_i * u_diff - eta_4 * rover_info.beta_sat - norm(u_diff)^2/norm(rover_info.beta_sat)^2 * rover_info.beta_sat );
            else
                rover_info.beta_sat = rover_info.beta_sat + time_step * (eta_3 * rover_info.g_i * u_diff - eta_4 * rover_info.beta_sat);
            end
                
                
            
        end
        
        %% Step 5: Motor speed calculation
        function m_speed = motor_speed(~, u_i, gear_constant, wheel_R, step_size_motor)
            m_speed = u_i * 100 * gear_constant / (pi * wheel_R * step_size_motor);
        end

    end

end







