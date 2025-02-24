clear;clc;close all

%% Question 7

PRN4 = CA_Code_Gen(14,1,1);
PRN7 = CA_Code_Gen(7,1,1);

subplot(2,2,1)
stairs(1:16,PRN4(1:16))
grid on
title("First 16 Bits PRN 4")
xlabel("Bit #")
xlim([1 16])
ylabel("Bit Value")
ylim([-1 2])
subplot(2,2,2)
stairs(1:16,PRN7(1:16))
grid on
title("First 16 Bits PRN 7")
xlabel("Bit #")
xlim([1 16])
ylabel("Bit Value")
ylim([-1 2])
subplot(2,2,3)
stairs(1023-16:1023,PRN4(1023-16:1023))
grid on
title("Last 16 Bits PRN 4")
xlabel("Bit #")
xlim([1023-16 1023])
ylabel("Bit Value")
ylim([-1 2])
subplot(2,2,4)
stairs(1023-16:1023,PRN7(1023-16:1023))
grid on
title("Last 16 Bits PRN 7")
xlabel("Bit #")
xlim([1023-16 1023])
ylabel("Bit Value")
ylim([-1 2])
