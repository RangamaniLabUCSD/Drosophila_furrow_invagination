
function [value,isterminal,direction] = ode_timeout(t_sym,ode)

if toc >= 45
    value = 0; % an event occurs when value = 0
else
    value = 1;
end

% these values are output by the function when value = 0
isterminal = 1; % terminates ode15s
direction = 0; % n/a - the event terminates when the value is either increasing or decreasing