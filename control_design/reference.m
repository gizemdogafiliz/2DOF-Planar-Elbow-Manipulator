function pos_ref = reference2(t)
    keyTimes = [0, 2, 4, 6]; % Time in seconds
    keyPositions = [1, 0;       % Position at t=0
                    0.6, 0;     % Position at t=2
                    0.4, 0.5;   % Position at t=4
                    0.8, 0.5];  % Position at t=6

    numSegments = length(keyTimes) - 1;

    if t <= keyTimes(1)
        posx = keyPositions(1, 1);
        posy = keyPositions(1, 2);
    end

    for i = 1:numSegments
        if t >= keyTimes(i) && t < keyTimes(i+1)
            % Perform linear interpolation
            fraction = (t - keyTimes(i)) / (keyTimes(i+1) - keyTimes(i));
            posx = keyPositions(i, 1) + fraction * (keyPositions(i+1, 1) - keyPositions(i, 1));
            posy = keyPositions(i, 2) + fraction * (keyPositions(i+1, 2) - keyPositions(i, 2));
            break;
        end
    end

    if t>= keyTimes(end)
        posx = keyPositions(end, 1);
        posy = keyPositions(end, 2);
    end

    % Output for debugging
    fprintf('Time t: %.6f\n', t);
    fprintf('Position X: %.5f, Position Y: %.5f\n', posx, posy);

    pos_ref = [posx; posy];
end

% %example reference code where the end effector moves from [0.7 0] to [0.4 0] in 2 seconds 
% treq1 = 2; %time required for motion to complete
% treq2 = 2;
% treq3 = 2;
% 
% if t<treq1
%     posx = 1;
%     posy = 0;
% elseif t<treq2
%     posx = 0.6;
%     posy = 0;
% elseif t<treq3
%     posx = 0.4;
%     posy = 0.5;
% else 
%     posx = 0.8;
%     posy = 0.5;
% end
% pos_ref = [posx; posy];
% plot(pos_ref);
% end

% %example reference code where the end effector moves from [0.7 0] to [0.4 0] in 2 seconds 
% treq = 2; %time required for motion to complete
% 
% if t<treq
%     posx = 0.7 - 0.3*(t/treq);
%     posy = 0;
% else
%     posx = 0.4;
%     posy = 0;
% end
% pos_ref = [posx; posy];
% end