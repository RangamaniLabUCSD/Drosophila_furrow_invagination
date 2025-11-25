
function [dL_kv,dL_md,dL_ms] = length_fn(L_kv,L_md,L_ms,f_m,f_mp,lambda_kv,lambda_ms,zeta_kv,zeta_md,pstruct)

% % Parameters
r_c = pstruct.r_c;
L_kv0 = pstruct.L_kv0;
L_md0 = pstruct.L_md0;
L_ms0 = pstruct.L_ms0;
mu_d = pstruct.mu_d;

% L_kv
dL_kv = (L_kv0./zeta_kv).*(((L_ms-L_ms0)./L_ms0).*lambda_ms - ((L_kv-L_kv0)./L_kv0).*lambda_kv);

% L_md
dL_md = ((L_ms-L_ms0)/L_ms0)*(lambda_ms*L_md0/zeta_md);

% L_ms
dL_ms = ((2*pi*r_c)./(mu_d.*(L_ms + L_kv + L_md))).*(f_mp - f_m - ((L_ms-L_ms0)./L_ms0).*lambda_ms) - dL_kv - dL_md;