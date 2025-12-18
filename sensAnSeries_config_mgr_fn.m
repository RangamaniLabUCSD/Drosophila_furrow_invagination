
function pstruct = sensAnSeries_config_mgr_fn(X)

% % Force per unit circumferential length and constitutive parameters table
f_mp0 = X(:,1);       % micro N/micro m. 
m1 = X(:,20);              % micro N/(micro m)^2. 
f_m0 = X(:,13);                 % micro N/micro m. 
lambda_kv0 = X(:,3);   % micro N/micro m. 
mu_d = X(:,4);         % micro N*s/micro m^2. 

% % Parameters just for the code
veAdd = 0;                  % Series (= 0) or parallel (= 1) addition of Kelvin-Voigt springs
var_lamMS = 0;              % Use lambda_ms as a parameter (= 0) or as a variable with a step change (= 1)
var_fmpL = 0;               % Different motor protein force cases

% % Time parameters table
tau_slw = X(:,5);                     % seconds. 
tau_fst = X(:,6);                % seconds. 
tau_stl = X(:,7);                   % seconds. 
tau_mpL = 5*60;                     % seconds. Time when f_mp0 turns on
tau_v = X(:,8);                   % seconds. 
tau_bfa = 100*60;                   % seconds. 
tau_kv = X(:,9);                        % seconds. 
tau_md = X(:,10);                       % seconds. 
tau_u_conc = X(:,11);    % micromolarity*seconds. 
tau_b = X(:,12);         % seconds. 
tanh_slope1 = 10^(2.5);         

% % Length parameters table
r_c = 2.7;                  % micro m. 
L_f0 = X(:,14);                  % micro m. 
L_T0 = X(:,15);                 % micro m. 
L_Tf = X(:,16);                  % micro m. 
L_mv = 2.1;                 % micro m. 

% % Area parameters table
alpha_m = X(:,2);                        % 1/micro m^2. 
alpha_v = X(:,17);                        % 1/micro m^2. 

% % Other parameters table
Phi_kv = .275;                   % Unitless.
Phi_nb = X(:,23);                      % Unitless.
n_b0 = X(:,18);                        % Unitless.   
n_u0 = X(:,19);                        % Unitless.   


% % Parameters that were brought in from main for sensitivity analysis
lambda_ms0 = X(:,21);
lambdaBar_kv = X(:,22);

% Overwrite default value
veAdd = 3;

% Do not use -- sampling
% pstruct.Phi_nb = .85;
% pstruct.tau_v = pstruct.tau_stl;

% Length parameters table
L_kv0 = L_T0./3;             % micro m. Range: .02/3 +.48/3,-0.0
L_ms0 = L_T0./3;             % micro m. Range: .02/3 +.48/3,-0.0
L_md0 = L_T0./3;             % micro m. Range: .02/3 +.48/3,-0.0

% Area parameters table
A_ua = pi.*r_c.^(2);                              % micro m^2
A_u0 = 2.*pi.*r_c.*L_T0;                   % micro m^2
A_v0 = A_ua + 2.*pi.*r_c.*L_f0;    % micro m^2
A_w0 = A_v0 - A_u0;                     % micro m^2
A_G = 2.*pi.*r_c.*(L_Tf - L_f0);   % micro m^2


% % Store in a structure
pstruct = struct( 'f_mp0',f_mp0,...
    'm1',m1,...
    'f_m0',f_m0,...
    'lambda_kv0',lambda_kv0,...
    'mu_d',mu_d,...
    'veAdd',veAdd,...
    'var_lamMS',var_lamMS,...
    'var_fmpL',var_fmpL,...
    'tau_slw',tau_slw,...
    'tau_fst',tau_fst,...
    'tau_stl',tau_stl,...
    'tau_v',tau_v,...
    'tau_bfa',tau_bfa,...
    'tau_kv',tau_kv,...
    'tau_md',tau_md,...
    'tau_u_conc',tau_u_conc,...
    'tau_b',tau_b,...
    'tau_mpL',tau_mpL,...
    'r_c',r_c,...
    'L_f0',L_f0,...
    'L_T0',L_T0,...
    'L_Tf',L_Tf,...
    'L_mv',L_mv,...
    'alpha_m',alpha_m,...
    'alpha_v',alpha_v,...
    'Phi_kv',Phi_kv,...
    'Phi_nb',Phi_nb,...
    'tanh_slope1',tanh_slope1,...
    'n_b0',n_b0,...
    'n_u0',n_u0,...
    'lambda_ms0',lambda_ms0,...
    'lambdaBar_kv',lambdaBar_kv,...
    'L_kv0',L_kv0,...
    'L_ms0',L_ms0,...
    'L_md0',L_md0,...
    'A_ua',A_ua,...
    'A_u0',A_u0,...
    'A_v0',A_v0,...
    'A_w0',A_w0,...
    'A_G',A_G);






















