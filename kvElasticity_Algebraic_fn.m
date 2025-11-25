
function [lambda_kv] = kvElasticity_Algebraic_fn(t_sym,pstruct)

% % Parameters
Phi_kv = pstruct.Phi_kv;
lambda_kv0 = pstruct.lambda_kv0;
tau_fst = pstruct.tau_fst;

% % Kelvin-Voigt elasticity
slope = 10^(-.5);
x = t_sym;
xtrans = tau_fst;

on_lambdaKV = MrSmooth(slope,x,xtrans,1);
off_lambdaKV = MrSmooth(slope,x,xtrans,-1);
lambda_kv = lambda_kv0.*(off_lambdaKV + Phi_kv.*on_lambdaKV);