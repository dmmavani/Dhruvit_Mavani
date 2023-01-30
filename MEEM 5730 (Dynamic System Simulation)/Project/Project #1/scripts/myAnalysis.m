%% Run and Analyze Simulation Results
% After cleaning up the workspace, the simulator just needs a few lines of
% code: define the dynamic system using a cell array, call the
% simulator and finally plot the results.

%%
% Cleanup
clearvars;
close all

%%
% Define the dynamic system model
% x' = f(x,u,t) where f and u(t) are MATLAB functions
% y  = g(x,u,t) is also a MATLAB function
%
% For the first dynamic system, we'll name f, g and u: f1, g and u1. The
% cell array below contains the three function handles to these functions
% and the initial conditions. For the "1" system, the initial condition is
% a scalar. For the other dynamic systems in the project, this element will
% be an array of initial conditions. Note that g is just named g and not
% g1. That's because all of the dynamic systems used in the project have
% the same output function and we'll use it for "2", "3" etc.
s1 = {@f1,@g,@u1,2.0};    % DS 1: x' = -4x + u
s2 = {@f2,@g,@u2,[0;0]'}; % DS 2: LTV
s3 = {@f3,@g,@u3,[0;0]'}; % DS 3: Van der Pol

 
%%
% Simulate the dynamic system using mySim. We pass it the cell array above,
% the end time, the time step, and a string indicating the integration
% method we want to use. The simulator returns: time, outputs, and inputs.
%
% If you'd like to use this script for the ther other integration methods,
% just develop a naming convention and append 8 more lines of code...
[euDS1.t,euDS1.y,euDS1.u] = mySim(s1, 4.0,0.01,'euler'); % DS 1 
[euDS2.t,euDS2.y,euDS2.u] = mySim(s2,10.0,0.01,'euler'); % DS 2
[euDS3.t,euDS3.y,euDS3.u] = mySim(s3,50.0,0.01,'euler'); % DS 3

[abDS1.t,abDS1.y,abDS1.u] = mySim(s1, 4.0,0.01,'ab2'); % DS 1 
[abDS2.t,abDS2.y,abDS2.u] = mySim(s2,10.0,0.01,'ab2'); % DS 2
[abDS3.t,abDS3.y,abDS3.u] = mySim(s3,50.0,0.01,'ab2'); % DS 3

[rkDS1.t,rkDS1.y,rkDS1.u] = mySim(s1, 4.0,0.01,'rk4'); % DS 1 
[rkDS2.t,rkDS2.y,rkDS2.u] = mySim(s2,10.0,0.0001,'rk4'); % DS 2
[rkDS3.t,rkDS3.y,rkDS3.u] = mySim(s3,50.0,0.01,'rk4'); % DS 3


%% 
% Plot results for DS1 and DS2. If you plan to use this script for making
% other plots (e.g. DS3 AND the other integration methods...) then you'll
% need to modify and likely add some new plotting routines. But, you can
% use this one as a template.
eu1.h = plotData1(euDS1);
eu2.h = plotData2(euDS2);
eu3.h = plotData2(euDS3);

ab1.h = plotData1(abDS1);
ab2.h = plotData2(abDS2);
ab3.h = plotData2(abDS3);

rkDS1.h = plotData1(rkDS1);
rkDS2.h = plotData2(rkDS2);
rkDS3.h = plotData2(rkDS3);

% ggpnew
% Create some interesting results to compare:
[euDS2.t,euDS2.y,euDS2.u] = mySim(s2,10.0,0.01,'euler'); % DS 2
[abDS2.t,abDS2.y,abDS2.u] = mySim(s2,10.0,0.01,'ab2'); % DS 2
[rkDS2.t,rkDS2.y,rkDS2.u] = mySim(s2,10.0,0.0001,'rk4'); % DS 2
% Create a plot that shows a 'typical' input / output set. We'll use RK4
% since this should be quite close to truth due to its small time step
rkDS2.h = plotData2(rkDS2);
% create a plot comparing euler, ab2 to rk4 for ds2 where it's assumed that
% a very small time step has been used for rk4 and so it can be assumed to
% be very close to the exact solution.
DS2Compare.h = plotDataDS2Compare(euDS2,abDS2,rkDS2);

print(rkDS2.h.fig,'figy1','-dpng');
print(DS2Compare.h.fig,'figy2','-dpng');


%% Helper Functions

function h = plotData1(dat)
% PLOTDATA1 plots the input and output for dynamic system 1 and returns a
% handle to the plot, h.
%
% The argument dat is a structure with fields: t, y, and u. The function

  % plot settings
  FS = 14; % font size
  LW =  2; % line width
  
  % In case you have some open figures... these lines will find an
  % available id for the new figure
  figs =  findobj('type','figure'); % find all the open figures
  id   = length(figs) + 1;          % create an id for this fig

  % Create a new figure window and axes
  h.fig   = figure(id);
  h.axs   = axes;
  
  % Plot the data using zero order hold between points, stairs.
  [x,y]   = stairs(dat.t,dat.y);   % create stair data for the output
  h.ln(1) = line(x,y,'Color','k'); % output
  [x,y]   = stairs(dat.t,dat.u);   % create stair data for the input
  h.ln(2) = line(x,y,'Color','b'); % input

  % Formatting
  grid;  
  h.xlb   = xlabel('Time (s)');
  h.ylb   = ylabel('In and Out');
  h.ttl   = title('$\dot{x} = -4x, \; x(0) = 2$');
  h.leg   = legend('y','u');
  
  h.ttl.Interpreter = 'LaTeX'; % Allows equations in the title string.  
  h.axs.FontWeight  = 'Bold';
  h.axs.FontSize    = FS;
  for i=1:length(h.ln)
    h.ln(i).LineWidth = LW;
  end

end

function h = plotData2(dat)
% PLOTDATA2 plots the input and output for dynamic system 2 and returns a
% handle to the plot, h.
%
% The argument dat is a structure with fields: t, y, and u. The function

  % plot settings
  FS = 14; % font size
  LW =  2; % line width
  
  % In case you have some open figures... these lines will find an
  % available id for the new figure
  figs =  findobj('type','figure'); % find all the open figures
  id   = length(figs) + 1;          % create an id for this fig

  % Create a new figure window
  h.fig      = figure(id);
  
  % Plot the data using zero order hold between points, stairs.
  h.axs(1)= subplot(2,1,1);  
  [x,y]   = stairs(dat.t,dat.u);   % create stair data for the input
  h.ln(1) = line(x,y,'Color','b'); % input 
  grid;
  h.xlb(1)   = xlabel('Time (s)');
  h.ylb(1)   = ylabel('u');
  h.ttl   = title('$m\ddot{w} + c\dot{w} + k(t)w = u$');
  
  
  h.axs(2)= subplot(2,1,2);
  [x,y]   = stairs(dat.t,dat.y);   % create stair data for the output
  h.ln(2) = line(x(:,1),y(:,1),'Color','k'); % x1
  h.ln(3) = line(x(:,2),y(:,2),'Color','r'); % 
  grid;
  h.leg   = legend('x_1','x_2','u');
  h.xlb(2)   = xlabel('Time (s)');
  h.ylb(2)   = ylabel('States');  
  
  h.ttl.Interpreter = 'LaTeX'; % Allows equations in the title string.  
  
  for i=1:length(h.axs)
    h.axs(i).FontWeight  = 'Bold';
    h.axs(i).FontSize    = FS;
  end
  
  for i=1:length(h.ln)
    h.ln(i).LineWidth = LW;
  end

end

function h = plotDataDS2Compare(eu,ab,rk)
% h= PLOTDATADS2COMPARE creates a plot comparing euler, ab2 and rk4 data
% for dynamic system #2.
%
  % plot settings
  FS = 14; % font size
  LW =  2; % line width
  
  % In case you have some open figures... these lines will find an
  % available id for the new figure
  figs =  findobj('type','figure'); % find all the open figures
  id   = length(figs) + 1;          % create an id for this fig

  % Create a new figure window
  h.fig      = figure(id);
  %h.axs   = axes;
  
  % Resample so all of it has the same number of points
  euFine = interp1(eu.t,eu.y,rk.t);
  abFine = interp1(ab.t,ab.y,rk.t);
  
  % Add some lines to the figure for output 1 (e.g. x1)
  subplot(2,1,1,'FontWeight','Bold','FontSize',FS); % top axis
  line(rk.t,abs(euFine(:,1)-rk.y(:,1)),'Color','k','LineWidth',LW); % euler, output 1
  line(rk.t,abs(abFine(:,1)-rk.y(:,1)),'Color','b','LineWidth',LW); % ab2, output 1
  grid;
  ylabel('X_1 Differences');
  legend('Euler','AB-2','location','NorthWest');
  
  % Add some lines to the figure for output 2 (e.g. x2)
  subplot(2,1,2,'FontWeight','Bold','FontSize',FS); % bottom axis
  line(rk.t,abs(euFine(:,2)-rk.y(:,2)),'Color','k','LineWidth',LW); % euler, output 2
  line(rk.t,abs(abFine(:,2)-rk.y(:,2)),'Color','b','LineWidth',LW); % ab2, output 2
  grid;
  ylabel('X_2 Differences');
  xlabel('Time (s)');
  
%   [x,y]   = stairs(dat.t,dat.y);   % create stair data for the output
%   h.ln(1) = line(x,y,'Color','k'); % output
%   [x,y]   = stairs(dat.t,dat.u);   % create stair data for the input
%   h.ln(2) = line(x,y,'Color','b'); % input


end


