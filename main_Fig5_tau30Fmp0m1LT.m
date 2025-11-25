
close all
clear 
clc

% % Configure simulation
[pstruct] = config_global_fn();
pstruct.fileName = "Fig5_tau30Fmp0m1LT_v";
pstruct.veAdd = 1;
pstruct.var_fmpL = 2;
pstruct.tau_v = pstruct.tau_fst;

% % ==================================================================% %
% % Dependent parameters

% Force per unit circumferential length and constitutive parameters table
pstruct.lambda_ms0 = pstruct.lambda_kv0;                    % micro N/micro m. Range: lambda_kv0*50% COV
pstruct.lambdaBar_kv = pstruct.lambda_kv0;

% Length parameters table
pstruct.L_kv0 = pstruct.L_T0/3;             % micro m. Range: .02/3 +.48/3,-0.0
pstruct.L_ms0 = pstruct.L_T0/3;             % micro m. Range: .02/3 +.48/3,-0.0
pstruct.L_md0 = pstruct.L_T0/3;             % micro m. Range: .02/3 +.48/3,-0.0

% Area parameters table
pstruct.A_ua = pi*pstruct.r_c^(2);                              % micro m^2
pstruct.A_u0 = 2*pi*pstruct.r_c*pstruct.L_T0;                   % micro m^2
pstruct.A_v0 = pstruct.A_ua + 2*pi*pstruct.r_c*pstruct.L_f0;    % micro m^2
pstruct.A_w0 = pstruct.A_v0 - pstruct.A_u0;                     % micro m^2
pstruct.A_G = 2*pi*pstruct.r_c*(pstruct.L_Tf - pstruct.L_f0);   % micro m^2

% % ==================================================================% %


% % Initial conditions
L_kv0 = pstruct.L_kv0;
L_md0 = pstruct.L_md0;
L_ms0 = pstruct.L_ms0;
L_T0 = pstruct.L_T0;
A_v0 = pstruct.A_v0;
n_b0 = pstruct.n_b0;
n_u0 = pstruct.n_u0;
A_u0 = pstruct.A_u0;
A_w0 = pstruct.A_w0;

ICs = [L_kv0,L_md0,L_ms0,L_T0,A_v0,n_b0,n_u0,A_u0,A_w0];
tspan = [0 100]*60;

% % Solve ODEs
ode_options = odeset('NonNegative',[9,6,7]);
[t_out,y_out] = ode15s(@(t_sym,ode) ode_fn(t_sym,ode,pstruct),tspan,ICs,ode_options);

% % Recalculate auxiliary variables
    % Kelvin-Voigt elasticity without a mechanism, Phi_lambda
    [lambda_kv] = kvElasticity_fn(t_out,y_out(:,6),pstruct);
    
    % Viscoelastic variables: Kelvin-Voigt and Maxwell dashpots, and the Maxwell spring 
    [zeta_kv, zeta_md, lambda_ms] = viscoElas_fn(lambda_kv,y_out(:,3),pstruct);

    % Merge
    aux_out = [lambda_kv, zeta_kv, zeta_md, ones(length(t_out),1)*lambda_ms];

% % Save data
    % Create path
    fileStringName = pstruct.fileName;
    currentFilePath = mfilename('fullpath');
    [filepath,name,ext] = fileparts(currentFilePath);
    folderVersion = 1;
    folderName = strcat(fileStringName,string(folderVersion));
    fileName = strcat(fileStringName,string(folderVersion),'.mat');
    resultsFolderPath = fullfile(filepath,folderName);
    while exist(resultsFolderPath,'dir')
        folderVersion = folderVersion + 1;
        folderName = strcat(fileStringName,string(folderVersion));
        fileName = strcat(fileStringName,string(folderVersion),'.mat');
        resultsFolderPath = fullfile(filepath,folderName);
    end
    mkdir(resultsFolderPath)
    resultsFilePath = fullfile(resultsFolderPath,fileName);
    % Model version data
    [versionStatus, versionCommitHash] = system('git rev-parse HEAD');


    save(resultsFilePath,"ode_options","pstruct","y_out","t_out","aux_out","versionStatus","versionCommitHash")

% % Save plots
    % Length, L_T
    f1 = figure(1);
    plot(t_out./60,y_out(:,4))
    xlim([0 90])
    ylim([0 40])
    ylabel('Furrow length (\mum)')
    xlabel('Time (min)')

    figDir1 = fullfile(resultsFolderPath,"fig_1.png"); 
    exportgraphics(f1,figDir1,'Resolution',300)

    % Wrinkled area, A_w
    f2 = figure(2);
    plot(t_out./60,y_out(:,9)./y_out(1,9))
    xlim([0 90])
    ylabel('Fold change of wrinkled area')
    xlabel('Time (min)')

    figDir2 = fullfile(resultsFolderPath,"fig_2.png"); 
    exportgraphics(f2,figDir2,'Resolution',300)

    % Bound linkers, n_b
    f3 = figure(3);
    plot(t_out./60,y_out(:,6)./y_out(1,6))
    xlim([0 90])
    ylabel('Fold change of bound linkers')
    xlabel('Time (min)')

    figDir3 = fullfile(resultsFolderPath,"fig_3.png"); 
    exportgraphics(f3,figDir3,'Resolution',300)

    % Kelvin-Voigt elasticity, lambda_kv
    f4 = figure(4);
    plot(t_out./60,lambda_kv./pstruct.lambda_kv0)
    xlim([0 90])
    ylabel('Fold change of Kelvin-Voigt elasticity')
    xlabel('Time (min)')

    figDir4 = fullfile(resultsFolderPath,"fig_4.png"); 
    exportgraphics(f4,figDir4,'Resolution',300)

    % Kelvin-Voigt viscosity, zeta_kv
    f5 = figure(5);
    plot(t_out./60,zeta_kv./pstruct.lambda_kv0)
    xlim([0 90])
    ylabel('Normalized Kelvin-Voigt viscosity')
    xlabel('Time (min)')

    figDir5 = fullfile(resultsFolderPath,"fig_5.png"); 
    exportgraphics(f5,figDir5,'Resolution',300)

    % Maxwell dashpot viscosity, zeta_md
    f6 = figure(6);
    plot(t_out./60,zeta_md./pstruct.lambda_kv0)
    xlim([0 90])
    ylabel('Normalized Maxwell dashpot viscosity')
    xlabel('Time (min)')

    figDir6 = fullfile(resultsFolderPath,"fig_6.png"); 
    exportgraphics(f6,figDir6,'Resolution',300)










