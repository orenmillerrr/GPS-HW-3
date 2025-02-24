clear;clc;close all

%% Question 2 - Part A
sims = 1000;
time = 600;

sigma_1 = 0.1;
sigma_2 = 0.01;

for i = 1 : sims
    x1(i,:) = sigma_1*randn(1);
    x2(i,:) = sigma_2*randn(1);
    for t = 1:time-1
        x1(i,t+1) = sigma_1*randn(1) + x1(i,t);
        x2(i,t+1) = sigma_2*randn(1) + x2(i,t);
    end
end

MC_mean1 = mean(x1);
MC_var1 = var(x1);

MC_mean2 = mean(x2);
MC_var2 = var(x2);

plot(1:time,x1,'r')
hold on
grid on 
mu = plot(1:time,MC_mean1,'k');
sig = plot(1:time,MC_mean1+3*sqrt(MC_var1),'k--');
plot(1:time,MC_mean1-3*sqrt(MC_var1),'k--')
title("Error Growth of White Noise \sigma = 0.1")
legend([mu,sig], "\mu_{mc}", "\mu_{mc} +/- 3\sigma","Location","southwest")
xlabel("Time (sec)")
ylabel("Value")

figure
plot(1:time,x2,'r')
hold on
grid on 
mu = plot(1:time,MC_mean2,'k');
sigma = plot(1:time,MC_mean2+3*sqrt(MC_var2),'k--');
plot(1:time,MC_mean2-3*sqrt(MC_var2),'k--')
title("Error Growth of White Noise \sigma = 0.01")
legend([mu,sig], "\mu_{mc}", "\mu_{mc} +/- 3\sigma","Location","southwest")
xlabel("Time (sec)")
ylabel("Value")

figure
subplot(2,1,1)
plot(1:600,x1(1,:),"k")
grid on
title("Error Growth for One Simulation for \sigma = 0.01")
xlabel("Time (sec)")
ylabel("Value")
subplot(2,1,2)
plot(1:600,x2(1,:),"k")
grid on
title("Error Growth for One Simulation for \sigma = 0.1")
xlabel("Time (sec)")
ylabel("Value")


sigma_f1 = sigma_1*1*sqrt([1:600]);
sigma_f2 = sigma_2*1*sqrt([1:600]);

figure
subplot(2,1,1)
plot(1:600,sqrt(MC_var1),"k")
hold on 
grid on 
plot(1:600,sigma_f1,"--")
title("Error Growth Model vs. Monte-Carlo Results for \sigma = 0.1")
legend(["\sigma_{mc}" "\sigma_f_{w_1}"],"Location","southeast")
xlabel("Time (sec)")
ylabel("Value")
subplot(2,1,2)
plot(1:600,sqrt(MC_var2),"k")
hold on 
grid on 
plot(1:600,sigma_f2,"--")
title("Error Growth Model vs. Monte-Carlo Results for \sigma = 0.01")
legend(["\sigma_{mc}" "\sigma_f_{w_2}"],"Location","southeast")
xlabel("Time (sec)")
ylabel("Value")

%% Question 2 - Part B

figure
sgtitle("Histograms of Monte-Carlo Results for \sigma = 0.1")
subplot(2,2,1)
histogram(MC_mean1(1:150))
title("Time = 1 - 150")
subplot(2,2,2)
histogram(MC_mean1(151:300))
title("Time = 151 - 300")
subplot(2,2,3)
histogram(MC_mean1(301:450))
title("Time = 301 - 450")
subplot(2,2,4)
histogram(MC_mean1(451:600))
title("Time = 451 - 600")

figure
sgtitle("Histograms of Monte-Carlo Results for \sigma = 0.01")
subplot(2,2,1)
histogram(MC_mean2(1:150))
title("Time = 1 - 150")
subplot(2,2,2)
histogram(MC_mean2(151:300))
title("Time = 151 - 300")
subplot(2,2,3)
histogram(MC_mean2(301:450))
title("Time = 301 - 450")
subplot(2,2,4)
histogram(MC_mean2(451:600))
title("Time = 451 - 600")