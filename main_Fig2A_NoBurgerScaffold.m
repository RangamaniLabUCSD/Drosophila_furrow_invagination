
close all
clear 
clc

tspan = [0 75];

% Constant only
P.a = 0;
P.b = 1.7;
P.c = 0;
P.alpha_mL = 0;
P.L_T0 = 0.02;

[t_out,y_out] = ode15s(@(t,L_T) ode_Fig2A_NoBurgerScaffold(t,L_T,P), tspan, P.L_T0);
t_out = [0; t_out+5];
y_out = [P.L_T0; y_out];
t_outAll{1} = t_out;
y_outAll{1} = y_out;

figure;
p1 = plot(t_out,y_out/35,'b:');
hold on 

% Constant and force as a function of length
P.a = 1.7;

[t_out,y_out] = ode15s(@(t,L_T) ode_Fig2A_NoBurgerScaffold(t,L_T,P), tspan, P.L_T0);
t_out = [0; t_out+5];
y_out = [P.L_T0; y_out];
t_outAll{2} = t_out;
y_outAll{2} = y_out;

p2 = plot(t_out,y_out/35,'b--');

% Constant, force as a function of length, and an exponential length
% limitation
P.c =  0.02;
P.alpha_mL =  0.3450;

[t_out,y_out] = ode15s(@(t,L_T) ode_Fig2A_NoBurgerScaffold(t,L_T,P), tspan, P.L_T0);
t_out = [0; t_out+5];
y_out = [P.L_T0; y_out];
t_outAll{3} = t_out;
y_outAll{3} = y_out;

p3 = plot(t_out,y_out/35,'b-.');
axis([0 75 0 1.2])
xlabel('Time (min.)')
ylabel('Normalized furrow length')
legend('F_{mp0}','F_{mp}(L_{T})','F_{mp}(L_{T}), e^{L_{T}}')


% % Save data
    % Create path
    fileStringName = "Fig2A_NoBurgerScaffold_v";
    currentFilePath = mfilename('fullpath');
    [filepath,name,ext] = fileparts(currentFilePath);
    folderVersion = 1;
    folderName = strcat('Fig2A_NoBurgerScaffold_v',string(folderVersion));
    fileName = strcat(fileStringName,string(folderVersion),'.mat');
    resultsFolderPath = fullfile(filepath,folderName);
    while exist(resultsFolderPath,'dir')
        folderVersion = folderVersion + 1;
        folderName = strcat('Fig2A_NoBurgerScaffold_v',string(folderVersion));
        fileName = strcat(fileStringName,string(folderVersion),'.mat');
        resultsFolderPath = fullfile(filepath,folderName);
    end
    mkdir(resultsFolderPath)
    resultsFilePath = fullfile(resultsFolderPath,fileName);
    % Model version data
    [versionStatus, versionCommitHash] = system('git rev-parse HEAD');

    save(resultsFilePath,"y_outAll","t_outAll","versionStatus","versionCommitHash")


