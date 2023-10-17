function [t1,t2,t3,t4,t5,t6,t7,t8] = fVec(T1,T2,T3,T4,T5,T6,T7,T8,thrust) 
t1 = [cos(thrust.ang.T1); -sin(thrust.ang.T1); 0; sin(thrust.ang.T1)*(T1(3)/1000); cos(thrust.ang.T1)*(T1(3)/1000); -sin(thrust.ang.T1)*(T1(1)/1000)-cos(thrust.ang.T1)*(T1(2)/1000)];
t2 = [cos(thrust.ang.T2); -sin(thrust.ang.T2); 0; sin(thrust.ang.T2)*(T2(3)/1000); cos(thrust.ang.T2)*(T2(3)/1000); -sin(thrust.ang.T2)*(T2(1)/1000)-cos(thrust.ang.T2)*(T2(2)/1000)];
t3 = [cos(thrust.ang.T3); -sin(thrust.ang.T3); 0; sin(thrust.ang.T3)*(T3(3)/1000); cos(thrust.ang.T3)*(T3(3)/1000); -sin(thrust.ang.T3)*(T3(1)/1000)-cos(thrust.ang.T3)*(T3(2)/1000)];
t4 = [cos(thrust.ang.T4); -sin(thrust.ang.T4); 0; sin(thrust.ang.T4)*(T4(3)/1000); cos(thrust.ang.T4)*(T4(3)/1000); -sin(thrust.ang.T4)*(T4(1)/1000)-cos(thrust.ang.T4)*(T4(2)/1000)];
t5 = [0; 0; -1; -(T5(2)/1000); (T5(1)/1000); 0];
t6 = [0; 0; 1; (T6(2)/1000); -(T6(1)/1000); 0];
t7 = [0; 0; 1; (T7(2)/1000); -(T7(1)/1000); 0];
t8 = [0; 0; -1; -(T8(2)/1000);(T8(1)/1000); 0];
end