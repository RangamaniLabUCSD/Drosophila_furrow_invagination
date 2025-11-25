%% Notes
%{
Version: 2

%}

function [smooth] = MrSmooth(slope, x, xtrans, UpDown)

    smooth = (UpDown.*tanh(slope.*(x - xtrans)) + 1)./2;
    