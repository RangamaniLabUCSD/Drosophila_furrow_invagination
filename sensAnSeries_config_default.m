
function pstruct = sensAnSeries_config_default()

% % Force per unit circumferential length and constitutive parameters table
f_mp0 = 5.15*10^(-3);       % micro N/micro m. 
m1 = f_mp0/35;              % micro N/(micro m)^2. 
f_m0 = 100;                 % micro N/micro m. 
lambda_kv0 = 9.8*10^(-5);   % micro N/micro m. 
mu_d = 1.5*10^(-6);         % micro N*s/micro m^2. 

% % Parameters just for the code
veAdd = 0;                  % Series (= 0) or parallel (= 1) addition of Kelvin-Voigt springs
var_lamMS = 0;              % Use lambda_ms as a parameter (= 0) or as a variable with a step change (= 1)
var_fmpL = 0;               % Different motor protein force cases

% % Time parameters table
tau_slw = 0*60;                     % seconds. 
tau_fst = 33.75*60;                 % seconds. 
tau_stl = 60*60;                    % seconds. 
tau_mpL = 5*60;                     % seconds. Time when f_mp0 turns on
tau_v = 33.75*60;                   % seconds. 
tau_bfa = 100*60;                   % seconds. 
tau_kv = 10;                        % seconds. 
tau_md = 100;                       % seconds. 
tau_u_conc = (1.8*10^(-3))^(-1);    % micromolarity*seconds. 
tau_b = (1.8*10^(-3))^(-1);         % seconds. 
tanh_slope1 = 10^(2.5);         

% % Length parameters table
r_c = 2.7;                  % micro m. 
L_f0 = 20;                  % micro m. 
L_T0 = .02;                 % micro m. 
L_Tf = 35;                  % micro m. 
L_mv = 2.1;                 % micro m. 

% % Area parameters table
alpha_m = .5;                        % 1/micro m^2. 
alpha_v = 60;                        % 1/micro m^2. 

% % Other parameters table
Phi_kv = .275;                   % Unitless.
Phi_nb = 1;                      % Unitless.
n_b0 = 1;                        % Unitless.   
n_u0 = 1;                        % Unitless. 

% % Parameters that were brought in from main for sensitivity analysis


% Overwrite default value
veAdd = 3;
Phi_nb = .85;
tau_v = tau_stl;

% % ==================================================================% %
% % Dependent parameters

% Force per unit circumferential length and constitutive parameters table
lambda_ms0 = lambda_kv0;                    % micro N/micro m. Range: lambda_kv0*50% COV
lambdaBar_kv = lambda_kv0;

% Length parameters table
L_kv0 = L_T0./3;             % micro m. Range: .02/3 +.48/3,-0.0
L_ms0 = L_T0./3;             % micro m. Range: .02/3 +.48/3,-0.0
L_md0 = L_T0./3;             % micro m. Range: .02/3 +.48/3,-0.0

% Area parameters table
A_ua = pi.*r_c.^(2);                              % micro m^2
A_u0 = 2*pi.*r_c.*L_T0;                   % micro m^2
A_v0 = A_ua + 2*pi.*r_c.*L_f0;    % micro m^2
A_w0 = A_v0 - A_u0;                     % micro m^2
A_G = 2*pi.*r_c.*(L_Tf - L_f0);   % micro m^2

% % ==================================================================% %


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






















