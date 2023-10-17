function Ralpha = R_alpha(hyd)

% alpha = angle of attack 

alpha = hyd.ocean.flow.Alpha;
Ralpha = [cos(alpha), 0, sin(alpha); 0, 1, 0; -sin(alpha), 0, cos(alpha)];

end