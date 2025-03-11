clear;clc;close all

% % load RCVR_S1_data.mat
% % dataS1 = RCVR_S1;
% 
% load RCVR_D1_data.mat
% dataD1 = RCVR_D1;
% 
% psr_usr  = dataD1.measurements.L1.psr(1,:);
% psr_base = dataS1.measurements.L1.psr(1,:);

% Constants
c = 299792458; 
f_L1 = 1575.42*10^6;
lambda = 19.05/100;

load RCVR_D1_data.mat
dataD1 = RCVR_D1;
psr_usr  = dataD1.measurements.L1.psr(1,:);
time_usr = dataD1.GPS_time.seconds;

load RCVR_S1_data.mat
dataD2 = RCVR_S1;
ephem_base = dataD2.ephem;
psr_base  = dataD2.measurements.L1.psr(1,:);
time_base = dataD2.GPS_time.seconds;

idx = find((time_base == time_usr(1)));
psr_base  = dataD2.measurements.L1.psr(idx,:);
time_base = dataD2.GPS_time.seconds(idx);

[meas,SVs] = size(psr_base);

transit_time = psr_base ./ c;
transmit_time = time_base' - transit_time;

% Correct Semi-Major Axis if Needed
for i = 1:SVs
    if ephem_base(i).A < 10e5
        ephem_base(i).A = ephem_base(i).A^2;
    end
end


for j = 1 : SVs
    if isempty(ephem_base(j).A)  % check for empty ephem data - skip sat if blank
        sat_states(j,:) = NaN;
        sat_vels(j,:) = NaN; 
        clock_corr(j,1) = NaN;
        continue
    end

    [svState(j,:) sat_vels(j,:) svClkCorr(j,1)] = calc_gps_sv_pos(ephem_base(j), transmit_time(1,j), transit_time(1,j));
end

sv_bool = ~isnan(psr_usr);
psr_usr  = psr_usr(sv_bool);
psr_base = psr_base(sv_bool);
svClkCorr = svClkCorr(sv_bool);
svState   = svState(sv_bool,:)';

true =  [422596.629, -5362864.287, 3415493.797];
lla_tru = ecef2lla(true);

%% Question 6 - Part A

% 4 SVs
rcvr_base = gpsRCVR();
sol_base = p3d(rcvr_base,psr_base(1:4),svState(:,1:4),svClkCorr(1:4));

PDOP = norm(diag(sol_base.DOP));

fprintf("Question 6 - Part A (4 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)

figure
lla = ecef2lla(sol_base.state(1:3)');
geoplot(lla(1),lla(2),'*')
geolimits([32.585 32.587],[-85.495 -85.493])
geobasemap satellite
title("4 sv No Clock")

% 8 SVs
rcvr_base = gpsRCVR();
sol_base = p3d(rcvr_base,psr_base,svState,svClkCorr);

PDOP = norm(diag(sol_base.DOP));

fprintf("Question 6 - Part A (8 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)

figure
lla = ecef2lla(sol_base.state(1:3)');
geoplot(lla(1),lla(2),'*')
geolimits([32.585 32.587],[-85.495 -85.493])
geobasemap satellite
title("8 sv No Clock")


%% Question 6 - Part B 

rcvr_base = gpsRCVR();
sol_base = pt3d(rcvr_base,psr_base,svState,svClkCorr);

PDOP = norm(diag(sol_base.DOP));

fprintf("Question 6 - Part B (8 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)

figure
lla = ecef2lla(sol_base.state(1:3)');
geoplot(lla(1),lla(2),'*')
hold on
geoplot(lla_tru(1),lla_tru(2))
geolimits([32.585 32.587],[-85.495 -85.493])
geobasemap satellite
title("8 sv w/ Clock")

%% Question 6 - Part C

rcvr = gpsRCVR();
baseState = sol_base.state(1:3);
sol = ptSD3d(rcvr,psr_usr,psr_base,svState,baseState);

PDOP = norm(diag(sol.DOP));

fprintf("Question 6 - Part C (8 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)

figure
lla = ecef2lla(sol_base.state(1:3)');
geoplot(lla(1),lla(2),'*')
hold on
lla = ecef2lla(sol.usrPos(1:3)');
geoplot(lla(1),lla(2),'*')
geobasemap satellite
title("Single Difference")
legend("Base Station","Rover")

%% Question 6 - Part D

rcvr = gpsRCVR();
baseState = sol_base.state(1:3);
sol = ptDD3d(rcvr,psr_usr,psr_base,svState,baseState);

PDOP = norm(diag(sol.DOP));

fprintf("Question 6 - Part D (8 SVs)\n")
fprintf("PDOP: %.5f\n\n",PDOP)

figure
lla = ecef2lla(sol_base.state(1:3)');
geoplot(lla(1),lla(2),'*')
hold on
lla = ecef2lla(sol.usrPos(1:3)');
geoplot(lla(1),lla(2),'*')
geobasemap satellite
title("Double Difference")
legend("Base Station","Rover")




