
function [dA_u, dA_w] = area_fn(dA_v,dL_T,pstruct)

% % Parameters and variables
r_c = pstruct.r_c;

% % Unwrinkled area
dA_u = 2*pi*r_c.*dL_T;

% % Wrinkled area
dA_w = dA_v - dA_u;
