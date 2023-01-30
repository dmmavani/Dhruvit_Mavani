function [t,y,u] = myRK4(ss,tEnd,dt)
% [t,y,u] = MYAB2 Simulates a dynamic system, defined by the cell array ss, using AB-2 integration.
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
% 3. gFn from ss{2}
% 4. uFn from ss{3}
% 
% Author / Version
%

% Unpack the input cell array that contains function handles that define
% the dynamic system and its initial state array.

  fFn = ss{1};
  gFn = ss{2};
  uFn = ss{3};
  x0  = ss{4};

% create the time vector and acquire memory for the state, input and
% output arrays  
  [t,x,u,y] = initArrays(ss, tEnd, dt);

% Set the values of the first element, t=0, for the state, input and output
% arrays.
  x(1,:) = x0;               % the initial state from ss
  u(1,:) = uFn(0);           % u is a function of t only
  y(1,:) = gFn(x0,uFn(0),0); % Call y at x0, u0 and t=0 to get its initial value

% Implement RK-4 integration and keep track of the quantities that must
% be returned by the function. The notation below is similar to the course notes.
  for n=2:length(t)
    % function evaluations at whole and fractional time steps
    fn   = fFn(x(n-1,:),u(n-1,:),t(n-1));
    fnh  = fFn(x(n-1,:)+dt*fn/2, uFn(t(n-1)+dt/2), t(n-1)+dt/2 );
    fnhh = fFn(x(n-1,:)+dt*fnh/2, uFn(t(n-1)+dt/2), t(n-1)+dt/2); 
    fn1  = fFn(x(n-1,:)+dt*fnhh, uFn(t(n-1)+dt), t(n-1)+dt);
    % state update
    x(n,:) = x(n-1,:) + dt/6*(fn + 2*fnh + 2*fnhh + fn1);  
    
    % Update the input and output arrays that are returned by the function.  
    u(n,:) = uFn(t(n));        
    y(n,:) = gFn(x(n,:),u(n,:),t(n));
  end % for

end % myRK4
