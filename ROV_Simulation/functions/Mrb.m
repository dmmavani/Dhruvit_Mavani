function MRB = Mrb(rb)

% Mass-Matrix of a ROV
m = rb.m;
Ib = rb.Ib;
rg = rb.rg;
Srg = skewMtrx(rg);

MRB = [m*eye(3), -m*Srg; m*Srg, Ib] ;


end