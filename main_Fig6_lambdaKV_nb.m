
close all
clear
clc

% % Configure simulation
[pstruct] = config_global_fn();
pstruct.fileName = "Fig6_lambdaKV_nb_v";

lambdaBar_kv = pstruct.lambda_kv0;
Phi_nb = [.75 .85 .95];
n_b = linspace(.01,10);
fontS = 12;

f1 = figure(1);
for i = 1:length(Phi_nb)
    numerator = lambdaBar_kv.*Phi_nb(i).*n_b;
    denominator = 1 + Phi_nb(i).*(1-Phi_nb(i)).*(n_b.^2);
    lambda_kvSer(:,i) = (numerator./denominator);
    if i > 5
        plot(n_b,lambda_kvSer(:,i)./(pstruct.lambda_kv0),'DisplayName',sprintf('\x03A6_{nb}: %d',Phi_nb(i)),'LineWidth',1.5,'LineStyle','-')
    else
        plot(n_b,lambda_kvSer(:,i)./(pstruct.lambda_kv0),'DisplayName',sprintf('\x03A6_{nb}: %d',Phi_nb(i)),'LineWidth',1.5,'LineStyle','--')
    end
    if i == 1
        hold on
    end
    if i == length(Phi_nb)
        hold off
    end
end
ylim([0 2.5])
xlim([0 10])
ylabel('Fold change of Kelvin-Voigt elasticity','FontSize',fontS)
xlabel('Fold change of bound linkers','FontSize',fontS)
legend show;



f2 = figure(2);
for i = 1:length(Phi_nb)
    series = ((1-Phi_nb(i)).*n_b).^(-1);
    parallel = Phi_nb(i).*n_b;
    lambda_kvPar(:,i) = lambdaBar_kv.*(series + parallel);
    if i > 5
        plot(n_b,lambda_kvPar(:,i)./(pstruct.lambda_kv0),'DisplayName',sprintf('\x03A6_{nb}: %d',Phi_nb(i)),'LineWidth',1.5,'LineStyle','-')
    else
        plot(n_b,lambda_kvPar(:,i)./(pstruct.lambda_kv0),'DisplayName',sprintf('\x03A6_{nb}: %d',Phi_nb(i)),'LineWidth',1.5,'LineStyle','--')
    end
    if i == 1
        hold on
    end
    if i == length(Phi_nb)
        hold off
    end
end
ylim([0 25])
xlim([0 10])
ylabel('Fold change of Kelvin-Voigt elasticity','FontSize',fontS)
xlabel('Fold change of bound linkers','FontSize',fontS)
legend show;

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

    save(resultsFilePath,"pstruct","n_b","lambda_kvSer","lambda_kvPar","versionStatus","versionCommitHash")

figDir1 = fullfile(resultsFolderPath,"fig_1.png"); 
exportgraphics(f1,figDir1,'Resolution',300)

figDir2 = fullfile(resultsFolderPath,"fig_2.png"); 
exportgraphics(f2,figDir2,'Resolution',300)

% saveas(f1,'lambda_nb_ser',"svg")
% savefig(f1,"lambda_nb_ser")
% 
% saveas(f2,'lambda_nb_par',"svg")
% savefig(f2,"lambda_nb_par")
% 
% saveas(f3,'lambda_nb_serPar',"svg")
% savefig(f3,"lambda_nb_serPar")