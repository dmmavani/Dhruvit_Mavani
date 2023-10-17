function dnl = DNL(hyd,Vr) 
% Non-linear damping or Quadratic damping 

Xuu = hyd.dynamics.damping.Xuu;
Yvv = hyd.dynamics.damping.Yvv;
Zww = hyd.dynamics.damping.Zww;
Kpp = hyd.dynamics.damping.Kpp;
Mqq = hyd.dynamics.damping.Mqq;
Nrr = hyd.dynamics.damping.Nrr;
Vr = [Vr.ur,Vr.vr,Vr.wr,Vr.pr,Vr.qr,Vr.rr]';

dnl = -diag([Xuu*abs(Vr(1)),Yvv*abs(Vr(2)),Zww*abs(Vr(3)),Kpp*abs(Vr(4)),Mqq*abs(Vr(5)),Nrr*abs(Vr(6))]);

end

