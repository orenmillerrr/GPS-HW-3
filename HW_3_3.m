clear;clc;close all

%% Question 3

L1 = 1575.42 *10^6;
L2 = 1227.6 * 10^6;
L5 = 1176 * 10^6;

syms pL1 pL2 pL5

% L1-L2
p_IF_L12 = vpa(L1^2/(L1^2-L2^2)*pL1 + L2^2/(L1^2-L2^2)*pL2,4);
sigma_L12 = double(norm(coeffs(p_IF_L12)));

% L1 - L5
p_IF_L15 = vpa(L1^2/(L1^2-L5^2)*pL1 + L5^2/(L1^2-L5^2)*pL5,4);
sigma_L15 = double(norm(coeffs(p_IF_L15)));

% L2 - L5
p_IF_L25 = vpa(L2^2/(L2^2-L5^2)*pL2 + L5^2/(L2^2-L5^2)*pL5,4);
sigma_L25 = double(norm(coeffs(p_IF_L25)));