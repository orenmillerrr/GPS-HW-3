clear;clc;close all

sat_states = [0  300;
              100 400;
              700 400
              800 300];

base_state = [400 0];
user_state = [401 0];

% plot(sat_states(:,1),sat_states(:,2),'o')
% hold on 
% grid on 
% plot(user_state(1),user_state(2),"x")
% plot(base_state(1),base_state(2),"square")
% title("Scenario Viewer")
% xlabel("X Position")
% ylabel("Y Position")
% legend(["SVs" "User" "Basestation"],"Location","east")

%% Question 5 - Part A
r_user = sqrt((sat_states(:,1)-user_state(1)).^2 + (sat_states(:,2)-user_state(2)).^2);

% 2 Svs
r_user2 = r_user([1,4],:)';
sat_states2 = sat_states([1,4],:)';

rcvr = gpsRCVR([100;10]);

sol = p2d(rcvr,r_user2,sat_states2);

PDOP = sqrt(sol.DOP(1,1)^2 + sol.DOP(2,2)^2);

fprintf("Question 5 - Part A (2 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)

% 4 Svs
rcvr = gpsRCVR([100;10]);

sol = p2d(rcvr,r_user',sat_states');

PDOP = sqrt(sol.DOP(1,1)^2 + sol.DOP(2,2)^2);

fprintf("Question 5 - Part A (4 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)

%% Question 5 - Part B

r_user = sqrt((sat_states(:,1)-user_state(1)).^2 + (sat_states(:,2)-user_state(2)).^2);

rcvr = gpsRCVR([400;0]);

sol = pt2d(rcvr,r_user',sat_states');

PDOP = sqrt(sol.DOP(1,1)^2 + sol.DOP(2,2)^2);

fprintf("Question 5 - Part B (4 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)

%% Question 5 - Part C

r_user = sqrt((sat_states(:,1)-user_state(1)).^2 + (sat_states(:,2)-user_state(2)).^2);
r_base = sqrt((sat_states(:,1)-base_state(1)).^2 + (sat_states(:,2)-base_state(2)).^2);

rcvr = gpsRCVR;

sol = ptSD2d(rcvr,r_user',r_base',sat_states',base_state');

PDOP = sqrt(sol.DOP(1,1)^2 + sol.DOP(2,2)^2);

fprintf("Question 5 - Part C (4 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)

%% Question 5 - Part D

rcvr = gpsRCVR;

sol = ptDD2d(rcvr,r_user',r_base',sat_states',base_state');

PDOP = sqrt(sol.DOP(1,1)^2 + sol.DOP(2,2)^2);

fprintf("Question 5 - Part D (4 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)






