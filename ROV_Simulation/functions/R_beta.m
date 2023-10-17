function Rbeta = R_beta(hyd)

% beta = negative sideslip angle

beta = hyd.ocean.flow.Beta;
Rbeta = [cos(beta), sin(beta), 0; -sin(beta), cos(beta), 0; 0, 0, 1];

end