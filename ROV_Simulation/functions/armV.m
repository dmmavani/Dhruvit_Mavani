function [T5,T6,T7,T8] = armV(lxi,lyi,lzi)
% Thruster arm for all the vertical thrusters of ROV-2 Heavy
T5 = [lxi,lyi,lzi];
T6 = [lxi,-lyi,lzi];
T7 = [-lxi,lyi,lzi];
T8 = [-lxi,-lyi,lzi];
end