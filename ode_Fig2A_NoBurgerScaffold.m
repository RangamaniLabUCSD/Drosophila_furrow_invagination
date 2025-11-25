function dLTdt = odeL_T(t,L_T,P)
    dLTdt = (P.a*L_T + P.b - P.c*exp(P.alpha_mL*L_T))./(2*L_T);