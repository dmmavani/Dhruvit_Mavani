function CRB = Crb(rb,Vb)
% CRB = coriolis-centripetal force matrix
m = rb.m;         % Mass of a rigid-body
rg = rb.rg;       % Location of CG
Ib = rb.Ib;       % Moment of inertia matrix
Vb = [Vb.u,Vb.v,Vb.w,Vb.p,Vb.q,Vb.r]';   % Velocity of RB in {b} frame

% Derivables
v1 = Vb(1:3);
v2 = Vb(4:6);
Sv1 = skewMtrx(v1);
Sv2 = skewMtrx(v2);
Srg = skewMtrx(rg);
Ibv2 = Ib*v2;
SIbv2 = skewMtrx(Ibv2);

CRB = [zeros(3), -m*Sv1 - m*Sv2*Srg; -m*Sv1 + m*Srg*Sv2, -SIbv2];

end