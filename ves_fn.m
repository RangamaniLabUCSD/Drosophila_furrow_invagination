function [dA_v] = ves_fn(t_sym,pstruct)

% % Parameters and variables
A_G = pstruct.A_G;
tau_v = pstruct.tau_v;
tau_slw = pstruct.tau_slw;
tau_bfa = pstruct.tau_bfa;
tanh_slope1 = pstruct.tanh_slope1;

% % Total area flux from the Golgi
Phi_Goff = MrSmooth(tanh_slope1,t_sym,min(tau_bfa,tau_v),-1); 
dA_v = Phi_Goff.*(A_G./(tau_v - tau_slw));
if dA_v <= 10^(-10)
    dA_v = 0;
end


