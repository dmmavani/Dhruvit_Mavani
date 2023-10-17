function [T1,T2,T3,T4] = armH(lxi,lyi,lzi)
% Thruster arm for all the Horizontal thrusters of ROV-2 Heavy
T1 = [lxi,lyi,lzi];
T2 = [lxi,-lyi,lzi];
T3 = [-lxi,lyi,lzi];
T4 = [-lxi,-lyi,lzi];
end