
function [dn_b, dn_u] = bound_springs_fn(n_b,n_u,dA_v,dL_md,pstruct)

% % Parameters
L_md0 = pstruct.L_md0;
alpha_v = pstruct.alpha_v;
tau_u_conc = pstruct.tau_u_conc;
tau_b = pstruct.tau_b;
L_mv = pstruct.L_mv;
n_u0 = pstruct.n_u0;
r_c = pstruct.r_c;

% % Convert the binding rate to 1/s
c_ub = n_u0./(pi.*(r_c^2).*L_mv);
tau_u = tau_u_conc./c_ub;

% % Convert the characteristic bound and unbound times into rates
k_ub = tau_u.^(-1);
k_bu = tau_b.^(-1);

% % Bound springs
dn_b = k_ub.*n_u - k_bu.*n_b;

% % Unbound springs
depsilon_md = dL_md./L_md0;
dn_u = k_bu.*n_b - k_ub.*n_u + alpha_v.*dA_v - depsilon_md.*n_u;
        
