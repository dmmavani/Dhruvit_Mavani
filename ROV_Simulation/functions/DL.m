function dl = DL(hyd)
% Viscous drag or linear damping

Xu = hyd.dynamics.damping.Xu;
Yv = hyd.dynamics.damping.Yv;
Zw = hyd.dynamics.damping.Zw;
Kp = hyd.dynamics.damping.Kp;
Mq = hyd.dynamics.damping.Mq;
Nr = hyd.dynamics.damping.Nr;

dl = -diag([Xu,Yv,Zw,Kp,Mq,Nr]);

end
