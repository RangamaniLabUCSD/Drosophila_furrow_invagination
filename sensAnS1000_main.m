
function Y = sensAnS1000_main(X)

% % Configure simulation
[sensAn_pstruct] = sensAnSeries_config_mgr_fn(X);
[sensAn_pstruct_default] = sensAnSeries_config_default();  
% pstruct.fileName = "sensAnS1000_main_v";
% pstruct.veAdd = 3;
% pstruct.Phi_nb = .85;
% pstruct.tau_v = pstruct.tau_stl;

% % ==================================================================% %
% % Dependent parameters

% Force per unit circumferential length and constitutive parameters table
% pstruct.lambda_ms0 = pstruct.lambda_kv0;                    % micro N/micro m. Range: lambda_kv0*50% COV
% pstruct.lambdaBar_kv = pstruct.lambda_kv0;

% % Length parameters table
% pstruct.L_kv0 = pstruct.L_T0/3;             % micro m. Range: .02/3 +.48/3,-0.0
% pstruct.L_ms0 = pstruct.L_T0/3;             % micro m. Range: .02/3 +.48/3,-0.0
% pstruct.L_md0 = pstruct.L_T0/3;             % micro m. Range: .02/3 +.48/3,-0.0
% 
% % Area parameters table
% pstruct.A_ua = pi*pstruct.r_c^(2);                              % micro m^2
% pstruct.A_u0 = 2*pi*pstruct.r_c*pstruct.L_T0;                   % micro m^2
% pstruct.A_v0 = pstruct.A_ua + 2*pi*pstruct.r_c*pstruct.L_f0;    % micro m^2
% pstruct.A_w0 = pstruct.A_v0 - pstruct.A_u0;                     % micro m^2
% pstruct.A_G = 2*pi*pstruct.r_c*(pstruct.L_Tf - pstruct.L_f0);   % micro m^2

% % ==================================================================% %

% % Parameters
tau_slw = sensAn_pstruct.tau_slw;
tau_stl = sensAn_pstruct.tau_stl;

% % Initial conditions
L_kv0 = sensAn_pstruct.L_kv0;
L_md0 = sensAn_pstruct.L_md0;
L_ms0 = sensAn_pstruct.L_ms0;
L_T0 = sensAn_pstruct.L_T0;
A_v0 = sensAn_pstruct.A_v0;
n_b0 = sensAn_pstruct.n_b0;
n_u0 = sensAn_pstruct.n_u0;
A_u0 = sensAn_pstruct.A_u0;
A_w0 = sensAn_pstruct.A_w0;

ICs = [L_kv0,L_md0,L_ms0,L_T0,A_v0,n_b0,n_u0,A_u0,A_w0];
tspan = [tau_slw, ones(length(tau_slw),1).*tau_stl];

% % Evaluate the model for each combination of parameters
fnames = fieldnames(sensAn_pstruct);
fails = 0;
fails2 = 0;
for i = 1:size(X,1)
    for j = 1:length(fnames)
        valDim = length(sensAn_pstruct.(fnames{j}));
        if valDim == 1
            fieldVal = sensAn_pstruct.(fnames{j})(1);
            sensAn_pstruct_i.(fnames{j}) = fieldVal;
        else
            fieldVal = sensAn_pstruct.(fnames{j})(i);
            sensAn_pstruct_i.(fnames{j}) = fieldVal;
        end
    end
    tic;
    ode_options1 = odeset('NonNegative',[9,6,7],'Events',@ode_timeout);
    [t_out,y_out] = ode15s(@(t_sym,ode) sensAn_ode_fn(t_sym,ode,sensAn_pstruct_i),tspan(i,:),ICs(i,:),ode_options1);
    disp(i)

    [warnMsg, warnID] = lastwarn; 
    if ~isempty(warnMsg)
        lastwarn('','')
        fprintf('1st retry: %f\n',i)
        fails = fails + 1; 
        odeFail{fails,1} = i;
        odeFail{fails,2} = sensAn_pstruct_i;
        odeFail{fails,3} = warnMsg;
        odeFail{fails,4} = warnID;
        

        ode_options2 = odeset('NonNegative',[9,6,7]);
        [t_out,y_out] = ode15s(@(t_sym,ode) sensAn_ode_fn(t_sym,ode,sensAn_pstruct_default),tspan(i,:),ICs(i,:),ode_options2);
        [warnMsg, warnID] = lastwarn;
            if ~isempty(warnMsg)
                lastwarn('','')
                fprintf('2nd retry: %f\n',i)
                fails2 = fails2 + 1; 
                odeFail2{fails2,1} = i;
                odeFail2{fails2,2} = sensAn_pstruct_i;
                odeFail2{fails2,3} = warnMsg;
                odeFail2{fails2,4} = warnID;
                
        
                y_out = 35.*ones(length(t_out),9);
            end
            
    end
    Y(i) = y_out(end,4);
    ty_out{i,1} = t_out;
    ty_out{i,2} = y_out;
    
    lastwarn('','')
end
Y = Y(:);
if fails2 > 0
    save('fail2FilePathS1000.mat',"odeFail2")
end
if fails > 0
save('failFilePathS1000.mat',"odeFail")
end
save('ty_outFilePathS1000.mat',"ty_out")

