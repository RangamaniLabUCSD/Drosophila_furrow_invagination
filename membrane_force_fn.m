
function [f_m] = membrane_force_fn(A_w,pstruct)

% % Parameters
f_m0 = pstruct.f_m0;
alpha_m = pstruct.alpha_m;

% % Membrane force per unit length
f_m = f_m0.*exp(-alpha_m.*A_w);
