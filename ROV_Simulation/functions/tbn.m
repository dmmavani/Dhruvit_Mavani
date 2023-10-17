function Tbn = tbn(phi,theta)

% Tbn - Angular transformation matrix

Tbn = [1, sin(phi)*tan(theta), cos(phi)*tan(theta); 0,cos(phi),-sin(phi); 0, sin(phi)/cos(theta), cos(phi)/cos(theta)];

end