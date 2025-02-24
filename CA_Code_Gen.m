function [codes_L1CA] = CA_Code_Gen(sv,fs,form)

% sv:   the a n x 1 matrix of satellite vehiles to evaluate
% fs:   the number of samples per chip
% form: PRNs in binary (default is 0) or signed binary (-1)

if nargin < 2
    fs = 1;
    form = 0;
elseif nargin < 3
    form = 0;
end

if fs < 1
    error('chip per sample is less than 1')
end

chip_rate = 1.023e6;    % chip rate for CA code 1.023 MHz
SF = fs*chip_rate;      % sample frequency Hz

tap=[2 6;
     3 7;
     4 8;
     5 9;
     1 9;
     2 10;
     1 8;
     2 9;
     3 10;
     2 3;
     3 4;
     5 6;
     6 7;
     7 8;
     8 9;
     9 10;
     1 4;
     2 5;
     3 6;
     4 7;
     5 8;
     6 9;
     1 3;
     4 6;
     5 7;
     6 8;
     7 9;
     8 10;
     1 6;
     2 7;
     3 8;
     4 9;
     5 10;
     4 10;
     1 7;
     2 8;
     4 10];

G1 = ones(1,10);
G2 = ones(1,10);

% polynomial feedback of G1
pf1 = [0 0 1 0 0 0 0 0 0 1];

% polynomial feedback of G2
pf2 = [0 1 1 0 0 1 0 1 1 1];

codes_L1CA = zeros([length(sv) 1023]);

tap_sv = tap(sv,:);
for bit = 1:1023
    % use satillite tap to find chip value
    phase_selector = mod(sum(G2(tap_sv),2),2);
    codes_L1CA(:,bit) = mod(phase_selector+G1(:,end),2);

    % update G1 & G2 code generators
    G1_mod = mod(sum(G1.*pf1,2),2);
    G2_mod = mod(sum(G2.*pf2,2),2);

    G1 = [G1_mod G1(:,1:end-1)];
    G2 = [G2_mod G2(:,1:end-1)];
end

% convert prn's to signed binary
if form == -1
    codes_L1CA = codes_L1CA*2-1;
end
