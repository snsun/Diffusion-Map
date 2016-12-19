% Generate experimental setup and compute local covariances
% *************************************************
% The setup is stored in 'Data.mat'
%
% By Ronen Talmon (20.3.2012)
% *************************************************

%% Configuration
M = 2000;   % No of samples
N = 200;     % No of pertubations
L = 8;         % Length of correlation frame [samples]
P = 2^12;   % Length of excitation signal

%% AR poles

% Generate according to REAL (possitive) poles
LPC_pole_1 = 0.2 + 0.6  * rand(M, 1);
LPC_pole_2 = -0.2 - 0.6  * rand(M, 1);

a1 = -(LPC_pole_1 + LPC_pole_2);
a2 = LPC_pole_1 .* LPC_pole_2;

%% Create dataset
c = zeros(M,L); % the features/points
inv_Cc = zeros(L,L,M); % inverses of local covariance matrices

dt = 1e-4; % variance of small pertubations around the points
h = waitbar(0, 'Generating data');
for i = 1:M
    
    waitbar(i/M, h);
    
    % generate the "points"    
    w_i = randn(1, P); % arbitrary random input signal
    y_i = filter(1, [1, a1(i), a2(i)], w_i);

    % correlation
    corr_i = xcorr(y_i, L-1) / P;
    corr_i = corr_i(L:end);
    c(i,:) = corr_i;
    
    % poles perturbations
    LPC_pole_1_dt = LPC_pole_1(i) + sqrt(dt)*randn(N, 1);
    LPC_pole_2_dt = LPC_pole_2(i) + sqrt(dt)*randn(N, 1);
    
    a1_dt = -(LPC_pole_1_dt + LPC_pole_2_dt);
    a2_dt  = LPC_pole_1_dt .* LPC_pole_2_dt;
         
    Cc_dt = zeros(N,L);
    for j = 1:N        
        w_j = randn(1, P);
        y_j = filter(1, [1, a1_dt(j), a2_dt(j)], w_j);

        corr_j = xcorr(y_j, L-1) / P;
        corr_j = corr_j(L:end);
        Cc_dt(j,:) = corr_j;
    end
   
    % Estimate the covariance
    Cc = cov(Cc_dt)/dt;    
    inv_Cc(:,:,i) = pinv(Cc);
end
close(h);

save 'Data.mat' c inv_Cc LPC_pole_1 LPC_pole_2 a1 a2 M L
