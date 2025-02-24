clear;clc;close all

%% Question 8 - Part A

PRN4 = CA_Code_Gen(14,1,-1);
PRN7 = CA_Code_Gen(7,1,-1);

subplot(1,2,1)
histogram(PRN4)
title("PRN4")
xlabel("Bit")
ylabel("# of Occurances")
subplot(1,2,2)
histogram(PRN7)
title("PRN7")
xlabel("Bit")
ylabel("# of Occurances")

%% Question 8 - Part B

figure
subplot(2,1,1)
periodogram(PRN4)
title("PSD for PRN4")
subplot(2,1,2)
periodogram(PRN7)
title("PSD for PRN7")

%% Question 8 - Part C

[acorr_PRN4,idx4] = xcorr(PRN4);
[acorr_PRN7,idx7] = xcorr(PRN7);

figure
subplot(2,1,1)
plot(idx4,acorr_PRN4)
grid on
title("Autocorrelation of PRN4")
xlabel("Shift")
ylabel("Correlation")
subplot(2,1,2)
plot(idx7,acorr_PRN7)
grid on
title("Autocorrelation of PRN7")
xlabel("Shift")
ylabel("Correlation")

%% Question - Part D

[xcorr_PRN47,idx47] = xcorr(PRN4,PRN7);

figure
plot(idx47,xcorr_PRN47)
grid on
title("Cross Correlation of PRN4 and PRN7")
xlabel("Shift")
ylabel("Correlation")

