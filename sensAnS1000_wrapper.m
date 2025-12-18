
close all
clear
clc

% % Start UQLab
uqlab

% % Create and add the model
modelopts.mFile = 'sensAnS1000_main';
myModel = uq_createModel(modelopts);

% % Setup the parameters
iopts.Marginals(1).Name = 'f_mp0';
iopts.Marginals(1).Type = 'Uniform';
iopts.Marginals(1).Parameters = [2.6e-3, 7.7e-3]; % +/- 50%

iopts.Marginals(2).Name = 'alpha_m'; 
iopts.Marginals(2).Type = 'Uniform';
iopts.Marginals(2).Parameters = [.25, .75]; % +/- 50%

iopts.Marginals(3).Name = 'lambda_kv0';
iopts.Marginals(3).Type = 'Uniform';
iopts.Marginals(3).Parameters = [.8*10^(-5), 18.8*10^(-5)];

iopts.Marginals(4).Name = 'mu_d';
iopts.Marginals(4).Type = 'Uniform';
iopts.Marginals(4).Parameters = [7.5e-7, 2.25e-6]; % +/- 50%

iopts.Marginals(5).Name = 'tau_slw';
iopts.Marginals(5).Type = 'Uniform';
iopts.Marginals(5).Parameters = [0*60, 5*60];

iopts.Marginals(6).Name = 'tau_fst';
iopts.Marginals(6).Type = 'Uniform';
iopts.Marginals(6).Parameters = [23.75*60, 36.75*60];

iopts.Marginals(7).Name = 'tau_stl'; % checked
iopts.Marginals(7).Type = 'Uniform';
iopts.Marginals(7).Parameters = [50*60, 60*60];

iopts.Marginals(8).Name = 'tau_v'; % set to range of tau_fst or tau_slw 
iopts.Marginals(8).Type = 'Uniform';
iopts.Marginals(8).Parameters = [23.75*60, 60*60]; % tau_G 30 to tau_G 60

iopts.Marginals(9).Name = 'tau_kv'; 
iopts.Marginals(9).Type = 'Uniform';
iopts.Marginals(9).Parameters = [5, 15]; % +/- 50%

iopts.Marginals(10).Name = 'tau_md';  
iopts.Marginals(10).Type = 'Uniform';
iopts.Marginals(10).Parameters = [50, 150]; % +/- 50%

iopts.Marginals(11).Name = 'tau_u_conc'; 
iopts.Marginals(11).Type = 'Uniform';
iopts.Marginals(11).Parameters = [10^(-1), 10^(3)]; % From tables

iopts.Marginals(12).Name = 'tau_b';  
iopts.Marginals(12).Type = 'Uniform';
iopts.Marginals(12).Parameters = [10^(-1), 10^(3)]; % From tables

iopts.Marginals(13).Name = 'f_m0'; 
iopts.Marginals(13).Type = 'Uniform';
iopts.Marginals(13).Parameters = [75, 100];

iopts.Marginals(14).Name = 'L_f0'; 
iopts.Marginals(14).Type = 'Uniform';
iopts.Marginals(14).Parameters = [17, 23];

iopts.Marginals(15).Name = 'L_T0'; 
iopts.Marginals(15).Type = 'Uniform';
iopts.Marginals(15).Parameters = [.02, .5];

iopts.Marginals(16).Name = 'L_Tf'; 
iopts.Marginals(16).Type = 'Uniform';
iopts.Marginals(16).Parameters = [30, 45];

iopts.Marginals(17).Name = 'alpha_v'; 
iopts.Marginals(17).Type = 'Uniform';
iopts.Marginals(17).Parameters = [30, 90]; % +/- 50%

iopts.Marginals(18).Name = 'n_b0'; 
iopts.Marginals(18).Type = 'Uniform';
iopts.Marginals(18).Parameters = [0, 2];

iopts.Marginals(19).Name = 'n_u0'; 
iopts.Marginals(19).Type = 'Uniform';
iopts.Marginals(19).Parameters = [0, 2];

iopts.Marginals(20).Name = 'm1'; % checked
iopts.Marginals(20).Type = 'Uniform';
iopts.Marginals(20).Parameters = [1.4714e-4 .2575]; %f_mpL/L_T0 = .2575, f_mpL/L_Tf = 1.4714e-4, f_mpL/1 = 5.2e-3


% In main
iopts.Marginals(21).Name = 'lambda_ms0';
iopts.Marginals(21).Type = 'Uniform';
iopts.Marginals(21).Parameters = [.8*10^(-5), 18.8*10^(-5)];

iopts.Marginals(22).Name = 'lambdaBar_kv'; % checked
iopts.Marginals(22).Type = 'Uniform';
iopts.Marginals(22).Parameters = [4.9e-5 1.47e-4]; % +/- 50% of lambda_kv0

iopts.Marginals(23).Name = 'Phi_nb'; % checked
iopts.Marginals(23).Type = 'Uniform';
iopts.Marginals(23).Parameters = [.65 .95]; % cannot go to 0 because the lambda_kv will just be zero

myInput = uq_createInput(iopts);

% % Save default values that produce warnings


% % Run Morris' sensitivity analysis 
morrisSensOpts.Type = 'Sensitivity';
morrisSensOpts.Method = 'Morris';
morrisSensOpts.Morris.Cost = 45000;
morrisAnalysis = uq_createAnalysis(morrisSensOpts);

% %%
% % Run the sensitivity analysis:
% SRCAnalysis = uq_createAnalysis(morrisSensOpts);

%%
% Print the results of the analysis:
uq_print(morrisAnalysis)

%%
% Display a graphical representation of the results:
uq_display(morrisAnalysis)


% % Create paths to save data
    currentFilePath = mfilename('fullpath');
    [filepath,name,ext] = fileparts(currentFilePath);
    folderVersion = 1;
    folderName = strcat('Results_v',string(folderVersion));
    resultsFolderPath = fullfile(filepath,folderName);
    while exist(resultsFolderPath,'dir')
        folderVersion = folderVersion + 1;
        folderName = strcat('Results_v',string(folderVersion));
        resultsFolderPath = fullfile(filepath,folderName);
    end
    mkdir(resultsFolderPath)
    matName = strcat("results",string(morrisSensOpts.Morris.Cost),".mat");
    resultsFilePath = fullfile(resultsFolderPath,matName);
    
    % Model version data
    [versionStatus, versionCommitHash] = system('git rev-parse HEAD');
    
    % Report data on cases that produced warnings

    % UQLab data
    save(resultsFilePath,"iopts","modelopts","morrisAnalysis","morrisSensOpts","myInput","myModel", ...
        "versionStatus","versionCommitHash")














