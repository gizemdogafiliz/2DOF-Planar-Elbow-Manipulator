function g1_g2  = gravity_comp(q1_q2)
g = 9.81;  % Gravity constant
q1 = q1_q2(1);
q2 = q1_q2(2);
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
lc2 = 0.19443;                                                                                                  % Center of mass location for link 2 (from initial joint)

% Gravitational terms
g1 = (m1 * lc1 + m_link2 * l1) * g * cosd(q1) + m_link2 * lc2 * g * cosd(q1 + q2);
g2 = m_link2 * lc2 * g * cosd(q1 + q2);

g1_g2 = [g1; g2];
end


