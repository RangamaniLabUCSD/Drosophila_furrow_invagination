
function d_ode = sensAn_ode_fn(t_sym,ode,pstruct,i)

% % Initialize the system
d_ode = zeros(9,1);

% % Motor protein force
[f_mp] = motor_force_fn(t_sym,ode(4),pstruct);


% % In-plane membrane force
[f_m] = membrane_force_fn(ode(9),pstruct);


% % Kelvin-Voigt elasticity 
[lambda_kv] = kvElasticity_fn(t_sym,ode(6),pstruct);


% % Viscoelastic variables: Kelvin-Voigt and Maxwell dashpots, and the Maxwell spring 
[zeta_kv, zeta_md, lambda_ms] = viscoElas_fn(lambda_kv,ode(3),pstruct);


% % Furrow length
[dL_kv,dL_md,dL_ms] = length_fn(ode(1),ode(2),ode(3),f_m,f_mp,lambda_kv,lambda_ms,zeta_kv,zeta_md,pstruct);

    % Kelvin-Voigt length   
    d_ode(1) = dL_kv;
    
    % Maxwell dashpot length
    d_ode(2) = dL_md;
    
    % Maxwell spring length
    d_ode(3) = dL_ms;

    % Total length
    d_ode(4) = d_ode(1) + d_ode(2) + d_ode(3);


% % Intracellular membrane area
[dA_v] = ves_fn(t_sym,pstruct);

    % Vesicle-derived area transported to the plasma membrane surface   
    d_ode(5) = dA_v;


% % Bound and unbound springs
[dn_b, dn_u] = bound_springs_fn(ode(6), ode(7),d_ode(5),d_ode(2),pstruct);

    % Bound Kelvin-Voigt springs   
    d_ode(6) = dn_b;
    
    % Unbound Kelvin-Voigt springs
    d_ode(7) = dn_u;
    

% % Surface membrane area 
[dA_u, dA_w] = area_fn(d_ode(5),d_ode(4),pstruct);

    % Unwrinkled membrane area   
    d_ode(8) = dA_u;
    
    % Wrinkled membrane area
    d_ode(9) = dA_w;


    


