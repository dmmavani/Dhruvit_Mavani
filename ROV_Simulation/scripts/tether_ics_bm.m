xi = ics.ita.N;
yi = ics.ita.E;
zi = ics.ita.D;


knots = 11;
len_tet = 35;
ln_tet = len_tet/(knots-1);
z_tet_i = 0;
z1 = zi/2-ln_tet;

len_1 = len_tet/2-ln_tet;
x_tet=zeros(knots,1);
z_tet=zeros(knots,1);
if zi == len_tet
    z_tet = linspace(0,zi,knots)';
else
x1 = sqrt(len_1^2-z1^2);
a1 = (z1-z_tet_i)/(x1-0);
x_inc = x1/((knots-1)/2-1);

for i=2:1:(knots-1)/2
x_tet(i,1) = x_inc*(i-1);
end
z_tet(1:(knots-1)/2,1) = a1*x_tet(1:(knots-1)/2,1);
z2 = zi/2+ln_tet ;
x2 = sqrt(len_1^2-z1^2);
a2 = (zi-z2)/(0-x2);
x_tet((knots+1)/2:(knots-1)/2+2,1) = x2;
z_tet((knots+1)/2) = z2-ln_tet;
for i=(knots-1)/2+2:1:knots-1
x_tet(i+1,1) = (x2-x_inc*(i-((knots+1)/2)));
end
x_tet((knots-1)/2+1:(knots-1)/2+2,1) = x2;
z_tet((knots+1)/2+1:end,1) = a2*x_tet((knots+1)/2+1:end,1)+zi;
end
x_tet = x_tet+xi;
P10=[xi yi zi]';
P9=[-x_tet(10) yi z_tet(10) ]';
P8=[-x_tet(9) yi z_tet(9) ]';
P7=[-x_tet(8)  yi z_tet(8) ]';
P6=[-x_tet(7) yi z_tet(7)]';
P5=[-x_tet(6) yi z_tet(6)]';
P4=[-x_tet(5) yi z_tet(5)]';
P3=[-x_tet(4) yi z_tet(4)]';
P2=[-x_tet(3) yi z_tet(3)]';
P1=[-x_tet(2) yi z_tet(2)]';
P0=[xi yi 0]';