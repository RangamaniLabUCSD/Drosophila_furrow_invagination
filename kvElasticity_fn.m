
function [lambda_kv] = kvElasticity_fn(t_sym,n_b,pstruct)


% % Parameters
veAdd = pstruct.veAdd;
Phi_nb = pstruct.Phi_nb;
lambdaBar_kv = pstruct.lambdaBar_kv;
lambda_kv0 = pstruct.lambda_kv0;
tau_fst = pstruct.tau_fst;
Phi_kv = pstruct.Phi_kv;

% % Kelvin-Voigt elasticity
if veAdd == 0       % Series addion of springs 
    lambda_kv = lambdaBar_kv./n_b;

elseif veAdd == 1   % Parallel addition of springs   
    lambda_kv = lambdaBar_kv.*n_b;

elseif  veAdd == 2  % Parallel addition of series-parallel springs
    n_series = 1./((1-Phi_nb).*n_b);
    n_parallel = Phi_nb.*n_b;
    lambda_kv = lambdaBar_kv.*(n_series + n_parallel);

elseif  veAdd == 3  % Series addition of series-parallel springs
    numerator = lambdaBar_kv.*Phi_nb.*n_b;
    denominator = 1 + Phi_nb.*(1-Phi_nb).*(n_b.^2);
    lambda_kv = numerator./denominator;

elseif  veAdd == 4  % Constant lambda_kv
    lambda_kv = lambda_kv0;

elseif  veAdd == 5  % lambda_kv as a step function
    slope = 10^(-.5);
    x = t_sym;
    xtrans = tau_fst;
    
    on_lambdaKV = MrSmooth(slope,x,xtrans,1);
    off_lambdaKV = MrSmooth(slope,x,xtrans,-1);
    lambda_kv = lambda_kv0.*(off_lambdaKV + Phi_kv.*on_lambdaKV);

else
    disp('ERROR: kvElasticity_fn')
end

