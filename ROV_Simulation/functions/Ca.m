function CA = Ca(hyd,Vr)
% Adedd mass corolis-centripetal force

MA = Ma(hyd);          % Added mass-matrix
Vr = [Vr.ur,Vr.vr,Vr.wr,Vr.pr,Vr.qr,Vr.rr]';     % Relative velocity

% Derivables
A11 = MA(1:3,1:3);
A12 = MA(1:3,4:6);
A21 = MA(4:6,1:3);
A22 = MA(4:6,4:6);
v1r = Vr(1:3);
v2r = Vr(4:6);
x1 = A11*v1r + A12*v2r;
x2 = A21*v1r + A22*v2r;

CA = [zeros(3), -skewMtrx(x1); -skewMtrx(x1), -skewMtrx(x2)];

end