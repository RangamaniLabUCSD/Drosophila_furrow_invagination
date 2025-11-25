function [zeta_kv, zeta_md, lambda_ms] = viscoElas_fn(lambda_kv,L_ms,pstruct)

% % Parameters
lambda_ms0 = pstruct.lambda_ms0;
tau_kv = pstruct.tau_kv;
tau_md = pstruct.tau_md;
L_ms0 = pstruct.L_ms0;
var_lamMS = pstruct.var_lamMS;

% % Elastic-viscous coefficient coupling
zeta_kv = lambda_kv.*tau_kv;
zeta_md = lambda_kv.*tau_md; 

% % Maxwell spring coefficient
if var_lamMS == 0
    lambda_ms = lambda_ms0;
elseif var_lamMS == 1
    on_lambdaMS = MrSmooth(10^(-2),(L_ms-L_ms0)./L_ms0,.05,1);
    off_lambdaMS = MrSmooth(10^(-2),(L_ms-L_ms0)./L_ms0,.05,-1);
    lambda_ms = lambda_ms0.*(off_lambdaMS + (10^2).*on_lambdaMS);
end
