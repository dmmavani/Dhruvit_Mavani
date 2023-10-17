function g_ita = hydStat(ita,rb,phy,hyd)

% CG and CB location
r_g = [rb.rg]';
r_b = [hyd.statics.rbo]';

% Physical constants
m = rb.m;
g = phy.g;
rho = phy.rho;

% ROV Parameters
delV = hyd.statics.delV;
% Aw = rb.Aw;

% Weight due to g
W = m*g;

% Buoyancy
B = rho*g*delV;

% Force vectors
fgn = [0,0,W]';
fbn = -[0,0,B]';

% Restoring forces vector
g_ita = -[rotbn(ita.phi,ita.theta,ita.psi)'*fgn + rotbn(ita.phi,ita.theta,ita.psi)'*fbn;...
          cross(r_g,rotbn(ita.phi,ita.theta,ita.psi)'*fgn) + cross(r_b,rotbn(ita.phi,ita.theta,ita.psi)'*fbn)];

end


