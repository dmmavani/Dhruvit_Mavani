function MA = Ma(hyd)
% Added-mass matrix

Xud = hyd.dynamics.der.Xud;
Yvd = hyd.dynamics.der.Yvd;
Zwd = hyd.dynamics.der.Zwd;
Kpd = hyd.dynamics.der.Kpd;
Mqd = hyd.dynamics.der.Mqd;
Nrd = hyd.dynamics.der.Nrd;

MA = -diag([Xud,Yvd,Zwd,Kpd,Mqd,Nrd]);

end