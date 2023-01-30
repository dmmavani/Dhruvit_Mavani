function [t,x,u,y] = initArrays(ss, tEnd, dt)
% [t,x,u,y] = INITARRAYS(ss, tEnd, dt) initializes the time, state, input
% and output arrays used by the simulator. It's assumed that the system
% being simulated is of the form:
% x' = f(x,u,t)
% y  = g(x,u,t)
% where there are n states, m inputs and r outputs.
%
% The input ss is a cell array with 4
% elements: ss{1} is the function handle to the state derivatives function,
% though its not used in here, ss{2} is the function handle to the output
% function, ss{3} is the function handle to the input function and ss{4} is
% an nx1 or 1xn array of the initial states, x0. tEnd is the end time for
% the simulation and dt is the step size, both in seconds.
%
% The outputs are:
%   t: an Nx1 array of time points used for simulation
%   x: an Nxn array of states
%   u: an Nxm array of inputs
%   y: an Nxr array of outputs
% where N is the number of time points.

  % Use the function handles and initial condition in the ss cell array to
  % compute the number of: states (n), inputs: (m) and outputs (r)
  [n,r,m] = calcDims(ss);

  % Set the simulation end time. If tEnd is not an integer multiple of dt,
  % then tEnd is set to the next largest value.
  tEndSim = ceil(tEnd/dt)*dt;

  % Create the Nx1 time array
  t = (0:dt:tEndSim)';

  % Set the number of time points
  N = length(t);

  % Initialize the memory for the inputs, outputs and states
  u = zeros(N,m);
  y = zeros(N,r);
  x = zeros(N,n);

end

function [n,r,m] = calcDims(ss)
% [n,r,m] = CALCDIMS(ss) computes the number of: states (n), inputs: (m)
% and outputs (r)

  % Extract the required function handles and ic to make the syntax easier.
  yFn = ss{2};
  uFn = ss{3};
  x0  = ss{4};

  n = length(x0);      % number of states taken from the ic
  r = length(yFn(x0)); % evaluate the output fn at x0 and take r
  m = length(uFn(x0)); % evaluate the input fn at t=0 and take m
  
end