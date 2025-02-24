clear;clc;close all

sat_states = [0  300;
              100 400;
              700 400
              800 300];

base_state = [400 0];
user_state = [401 0];

plot(sat_states(:,1),sat_states(:,2),'o')
hold on 
grid on 
plot(user_state(1),user_state(2),"x")
plot(base_state(1),base_state(2),"square")
title("Scenario Viewer")
xlabel("X Position")
ylabel("Y Position")
legend(["SVs" "User" "Basestation"],"Location","east")

%% Question 2 - Part A
r_user = sqrt((sat_states(:,1)-user_state(1)).^2 + (sat_states(:,2)-user_state(2)).^2);

% 2 Svs
sat_states2 = sat_states([1,4],:);
err = inf; 
x = 100;
y = 10;

while err > 0.001
    for w = 1 : length(sat_states2)
        r_hat(w) = sqrt((sat_states2(w,1)-x)^2 + (sat_states2(w,2)-y)^2);
        G(w,1) = (x-sat_states2(w,1))/sat_states2(w,2);
        G(w,2) = (y-sat_states2(w,1))/sat_states2(w,2);
    end

    % Position Deltas
    delta_p  = r_user([1,4])' - (r_hat);
    deltas_psr  = pinv(G)*delta_p';
    delta_x  = deltas_psr(1);
    delta_y  = deltas_psr(2);

    x  = x + delta_x;
    y  = y + delta_y;

    err = norm([delta_x delta_y]);
end

G1 = G;
DOP1 = (G1'*G1)^-1;
PDOP1 = norm(diag(DOP1));

% 4 Svs
err = inf; 
x = 100;
y = 10;

while err > 0.00001
    for w = 1 : length(sat_states)
        r_hat(w) = sqrt((sat_states(w,1)-x)^2 + (sat_states(w,2)-y)^2);
        G(w,1) = (x-sat_states(w,1))/sat_states(w,2);
        G(w,2) = (y-sat_states(w,1))/sat_states(w,2);
    end

    % Position Deltas
    delta_p  = r_user' - (r_hat);
    deltas_psr  = pinv(G)*delta_p';
    delta_x  = deltas_psr(1);
    delta_y  = deltas_psr(2);

    x  = x + delta_x;
    y  = y + delta_y;

    err = norm([delta_x delta_y]);
end

G2 = G;
DOP2 = (G2'*G2)^-1;
PDOP2 = norm(diag(DOP2));




