function q1_q2  = invkine2(x_y)

    % shaft to shaft length of the links
    % link length 1 = 600mm = 0.6 m
    % link length 2 = 400mm = 0.4 m
    
    l1 = 0.6;
    l2 = 0.4;
    
    x = x_y(1);
    y = x_y(2);
    
    arg = (x^2 + y^2 - l1^2 - l2^2) / (2 * l1 * l2);
    if arg < -1 || arg > 1
        arg = max(-1, min(1, arg));
    end
    q2 = acosd(arg);
    
    q1 = atan2d(y, x) - atan2d((l2 * sind(q2)), (l1 + l2 * cosd(q2)));
    
    % q2 = acosd((x^2 + y^2 - l1^2 - l2^2)/(2*l1*l2));
    %q1 = atand(y/x) - atand((l2*sind(q2))/(l1+l2*cosd(q2)));
    
    q1_q2 = [q1; q2];
end


