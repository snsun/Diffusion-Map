% Main file for recovering auto-regressive poles
% *************************************************
% Recreate Figs. 3 and 4 from
% R. Talmon, D. Kushnir, R. R. Coifman, I. Cohen and S. Gannot,
% "Parametrization of Linear Systems Using Diffusion Kernels,"
% IEEE Trans. Signal Processing, Vol. 60, Issue 3, Mar. 2012, pp. 1159-1173.
% % seems very simple
% By Ronen Talmon (20.3.2012)
% *************************************************

%% Generate data
if (exist('Data.mat', 'file')~=2)
    GenerateARData;
else
    load 'Data.mat'
end

%% Recover parameters
Reparam;

%% Plot results
ShowAR;
