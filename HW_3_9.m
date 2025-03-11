clear;clc;close all

%% Question 9 
chip_rate = 1.023 * 10^6;
L1_freq = 1575.42 * 10^6;

PRN4 = CA_Code_Gen(4,1,-1);
PRN7 = CA_Code_Gen(7,1,-1);

time = 1e-3;                %(1/chip_rate*1023);
SF = 10*L1_freq;
t = [0:1/SF:time-1/SF];

N = length(t);
nyq = SF/2;
dF = SF/N;
f = [-nyq:dF:nyq-dF];

idx = ceil([1:(SF*time)]*(chip_rate/SF));
PRN4_up = PRN4(idx);
PRN7_up = PRN7(idx);

carrier = sin(2*pi*L1_freq*t);
%boc = sign(sin(2*pi*L1_freq*1e-3*t));

prn_carrier4 = PRN4_up.*carrier;
prn_carrier7 = PRN7_up.*carrier;

subplot(2,1,1)
plot(f*1e-6,mag2db(abs(fftshift(fft(prn_carrier4)))))
title("PRN 4")
xlim([1.57542e3-1e1  1.57542e3+1e1 ])
ylim([40 125])
xlabel('Frequency (MHz)')
ylabel('Spectrum Power (dB)')
grid on
% periodogram(prn_carrier4)
subplot(2,1,2)
plot(f*1e-6,mag2db(abs(fftshift(fft(prn_carrier7)))))
title("PRN 7")
xlim([1.57542e3-1e1  1.57542e3+1e1])
ylim([40 125])
xlabel('Frequency (MHz)')
ylabel('Spectrum Power (dB)')
grid on
% periodogram(prn_carrier7)




