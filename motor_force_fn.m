
function [f_mp] = motor_force_fn(t_sym,L_T,pstruct)

% % Parameters
f_mp0 = pstruct.f_mp0;
var_fmpL = pstruct.var_fmpL;
tau_mpL = pstruct.tau_mpL;
m1 = pstruct.m1;


% Motor protein force
if var_fmpL == 0
    f_mpL = f_mp0; 
elseif var_fmpL == 1
    f_mpL = m1*L_T;
elseif var_fmpL == 2
    f_mpL = f_mp0 + m1*L_T;
end

f_mp = f_mpL.*MrSmooth(1, t_sym, tau_mpL, 1);