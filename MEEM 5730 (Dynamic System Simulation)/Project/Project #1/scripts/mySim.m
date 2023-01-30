function [t,y,u] = mySim(ss,tEnd,dt,intMethod)
% [t,y,u] = MYSIM simulates a dynamic system, defined by the ss cell array
% using the selected integration method.
%
% Description
% Inputs
% Outputs
% Functions Called
% Author / Version

switch lower(intMethod)
  case 'euler'
    [t,y,u] = myEuler(ss,tEnd,dt);
  case 'ab2'
    [t,y,u] = myAB2(ss,tEnd,dt);
  case 'rk4'
    [t,y,u] = myRK4(ss,tEnd,dt);      
  otherwise
    error('oops');
end
  
