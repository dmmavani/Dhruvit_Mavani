function Rbn = rotbn(phi,theta,psi)
% Rbn - linear Rotational matrix

Rphi = [1,0,0; 0,cos(phi),-sin(phi); 0,sin(phi),cos(phi)];
Rtheta = [cos(theta),0,sin(theta); 0,1,0; -sin(theta),0,cos(theta)];
Rpsi = [cos(psi),-sin(psi),0; sin(psi),cos(psi),0; 0,0,1];

Rbn = Rpsi*Rtheta*Rphi;

end