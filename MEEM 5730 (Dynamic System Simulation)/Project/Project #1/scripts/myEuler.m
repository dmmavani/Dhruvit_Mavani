function [t,y,u] = myEuler(ss,tEnd,dt)
% MYEULER Simulates a dynamic system, defined by the cell array ss, using Euler integration.
%
% Inputs
% ss: A cell array containing function handles and the initial state
%  {1}: state derivatives function handle
%  {2}: output function handle
%  {3}: input function handle
%  {4}: initial state vector
% tEnd: Simulation end time (sec)
% dt: Simulation time step (sec)
%
% Outputs
% Let N be the number of simulation time points from t=0 to t=tEnd. Also, let r be the number
% of outputs and m the number of inputs. With this in mind...
% t: an Nx1 array of simulation time points
% y: an Nxr array of outputs
% u: an Nxm array of inputs
%
% Functions Called
% 1. initArrays
% 2. fFn from ss{1}
% 3. yFn from ss{2}
% 4. uFn from ss{3}
% 
% Author / Version
%

% Unpack the input cell array that contains function handles that define
% the dynamic system and its initial state array.

fFn = ss{1};
yFn = ss{2};
uFn = ss{3};
x0  = ss{4};

% create the time vector and acquire memory for the state, input and
% output arrays  
[t,x,u,y] = initArrays(ss, tEnd, dt);

% Set the values of the first element, t=0, for the state, input and output
% arrays.
x(1,:) = x0;               % the initial state from ss
u(1,:) = uFn(0);           % u is a function of t only
y(1,:) = yFn(x0,uFn(0),0); % Call y at x0, u0 and t=0 to get its initial value

% Implement Euler integration and keep track of the quantities that must
% be returned by the function. Euler integration is:
%
% x_n = x_{n-1} + dt*f_{n-1}
%
% where f_{n-1} == f( x_{n-1}, u_{n-1}, t_{n-1} )
%
for n=2:length(t)  % state update
  x(n,:) = x(n-1,:) + dt*fFn(x(n-1,:),u(n-1,:),t(n-1,:));    
  % Update the input and output arrays that are returned by the function. Hint: call the
  % uFn and yFn functions with the appropriate arguments.
  u(n,:) = uFn(t(n));
  % output
  y(n,:) = yFn(x(n,:),u(n,:),t(n,:));
end

% Create the cell array of function handles and the initial state
% ss   = {@f1,@g,@u1,[2]};
% 
% tEnd = 5.0;  % final time (s)
% dt   = 0.01; % time step (s)

% % Simulate
% [t,y,u] = myEuler(ss,tEnd,dt);

% % Display
% figure(1);plot(t,u);xlabel('Time (s)');ylabel('u');
% figure(2);plot(t,y);xlabel('Time (s)');ylabel('y');
