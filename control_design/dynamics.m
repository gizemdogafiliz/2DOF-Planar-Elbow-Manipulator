function [result] = dynamics2(input)

    T1 = input(1);
    T2 = input(2);
    q1 = input(3);
    q2 = input(4);
    q1dot = input(5);
    q2dot = input(6);
    
    g = 9.81;  % Gravity constant
    
    % shaft to shaft length of the links
    % link length 1 = 600mm = 0.6 m
    % link length 2 = 400mm = 0.4 m
    
    % center of mass of the 1st link = 288.18 mm = 0.28818 m
    % center of mass of the 2nd link = 194.43 mm = 0.19443 m; 
    
    % I_motor2 = (1/2)*m*r^2 = 0.1275510205 grams/ meter^2(assumed slinder with r = 5cm = 50 mm, about its axis of rotation)
    % I_motor_connector = 0.00810387 g/m^2
    % I_link1 = 32.56815715 grams/m_square (around x axis (Ixx) in my SolidWorks)
    % I_link2 = 8.60050262 grams/m_square (around x axis (Ixx) in my SolidWorks)
    
    % Parallel axis theorem: Io = Ic + M*d^2
    
    % Link lengths
    l1 = 0.6;  % Link 1 length in meters
    l2 = 0.4;  % Link 2 length in meters
    
                                                                                                                    % Masses in kg
    motor2_mass = 102.0408163 / 1000;                                                                               % Motor 2 mass in kg: 1N force correspondes to (1/gravity) kg -> (1/gravity)*1000grams
    motor2_connector_mass = 58.2 / 1000;                                                                            % Motor connector mass in kg: realized that it is needed to also add the motor connection part -> 58.2 grams
    m_link1 = 279.3 / 1000;                                                                                         % Link 1 mass in kg: mass of (only) link 1
    m1 = m_link1 + motor2_mass + motor2_connector_mass;                                                             % Total mass of link 1: mass of link 1 + mass of motor 2 + mass of motor connector
    m_link2 = 162.03 / 1000;                                                                                        % Link 2 mass in kg
    
                                                                                                                    % Center of mass locations in meters
    link1_CoM = 0.28818;                                                                                            % Center of mass location for link 1 (from initial axis of rotation)       
    motor2_CoM = 0.5;                                                                                               % Center of mass location for motor 2
    motor_connector_CoM = 0.5;                                                                                      % Center of mass location for motor connector
    lc1 = (m_link1 * link1_CoM + motor2_mass * motor2_CoM + motor2_connector_mass * motor_connector_CoM) / m1;      % Center of mass location for motor connector
    lc2 = l2 - 0.19443;                                                                                                  % Center of mass location for link 2 (from initial joint)
    
                                                                                                                    % Moments of inertia in kg*m^2
    I_link1 = 32.56815715 / 1e6;                                                                                    % Moment of inertia around the center of mass of (only) link 1
    I_motor2 = 0.1275510205 / 1e6;                                                                                  % Moment of inertia around the center of mass of (only) the 2nd motor.
    I_motor_connector = 0.00810387 / 1e6;                                                                           % Mmoment of inertia around the center of mass of (only) the 2nd motor's connector
    I1 = I_link1 + I_motor2 + I_motor_connector + ...                                                       
         (m_link1 * (lc1 - link1_CoM)^2) + ...
         (motor2_mass * (lc1 - motor2_CoM)^2) + ...
         (motor2_connector_mass * (lc1 - motor_connector_CoM)^2);                                                   % Moment of inertia around center of mass for link 1 (parallel to axis of rotation)
    I2 = 8.60050262 / 1e6;                                                                                          % Moment of inertia around center of mass for link 2 (parallel to axis of rotation)
    
    r = 1/4;        %gear reduction
    J = 118.2e-3;   %motor inertia in kg*m^2
    B = 129.6e-3;   %motor friction constant
    
    h = m_link2 * l1 * lc2 * sind(q2);
    d11 = m1 * (lc1^2) + m_link2 * (l1^2 + lc2^2 + 2 * l1 * lc2 * cosd(q2)) + I1 + I2;
    d12 = m_link2 * (lc2^2 + l1 * lc2 * cosd(q2)) + I2;
    d21 = d12;
    d22 = m_link2 * lc2^2 + I2;
    
    % Gravitational terms
    g1 = (m1 * lc1 + m_link2 * l1) * g * cosd(q1) + m_link2 * lc2 * g * cosd(q1 + q2);
    g2 = m_link2 * lc2 * g * cosd(q1 + q2);
    
    % Calculating accelerations
    q1dotdot = (T1 + 2 * h * q1dot * q2dot + h * q2dot^2 - g1 - r * B * q1dot - (d12 / d22) * (T2 - h * q1dot^2 - g2)) / (d11 - (d12 * d21 / d22) + r^2 * J);
    q2dotdot = (T2 - d21 * q1dotdot - h * q1dot^2 - g2 - r * B * q2dot) / (d22 + r^2 * J);
    
    result = [q1dotdot, q2dotdot];
end
