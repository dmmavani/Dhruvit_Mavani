%% Run and Analyze Simulation Results
% After cleaning up the workspace, the simulator just needs a few lines of
% code: define the dynamic system using a cell array, call the
% simulator and finally plot the results.

%% Cleanup
clearvars;
close('all');
 
%% Verification
verificationPlot = verifyLTI;

%% LTI Analysis
dsName = 'lti';
mySS = pickDynamicSystem(dsName);

% Euler Analysis
[eu.t, eu.y, eu.u] = mySim(mySS,5.0,0.01,'euler');
ltiEU = plotData(eu,dsName);

% AB-2 Analysis
%[ab.t, ab.y, ab.u] = mySim(mySS,5.0,0.01,'ab2'  );
%ltiAB = plotData(ab,dsName);

% RK-4 Analysis
%[rk.t, rk.y, rk.u] = mySim(mySS,5.0,0.01,'rk4'  );
%ltiRK = plotData(rk,dsName);

%% LTV Analysis
dsName = 'ltv';
mySS = pickDynamicSystem(dsName);

% Euler Analysis
[eu.t, eu.y, eu.u] = mySim(mySS,5.0,0.01,'euler');
ltvEU = plotData(eu,dsName);

% AB-2 Analysis
%[ab.t, ab.y, ab.u] = mySim(mySS,5.0,0.01,'ab2'  );
%ltvAB = plotData(ab,dsName);

% RK-4 Analysis
%[rk.t, rk.y, rk.u] = mySim(mySS,5.0,0.01,'rk4'  );
%ltvRK = plotData(rk,dsName);

%% VDP Analysis
dsName = 'vdp';
mySS = pickDynamicSystem(dsName);

% Euler Analysis
[eu.t, eu.y, eu.u] = mySim(mySS,60,0.001,'euler');
vdpEU = plotData(eu,dsName);

%% Comparisons

% Euler and VDP Analysis
mySS = pickDynamicSystem('vdp');
[eu1.t, eu1.y, eu1.u] = mySim(mySS,30,0.001,'euler');
[eu2.t, eu2.y, eu2.u] = mySim(mySS,30,0.01,'euler');
euler_001_to_01_Plot = compareData(eu1,eu2,2); % state #2

% Add some code here for the Van der Pol time step analysis needed for the
% report.

% DONE!

%% Helper Functions

function mySS = pickDynamicSystem(sysName)
% mySS PICKDYNAMICSYSTEM(sysName) creates a cell array that describes the
% dynamic system: LTI, LTV, or van Der Pol

  switch lower(sysName)
      case 'lti'
        mySS = {@f1,@g,@u1,2.0}; % DS 1: x' = -4x + u, x0 = 2
    case 'ltv'
        mySS = {@f2,@g,@u2,[0 0]}; % DS 2: LTV, x0 = [0 0]
    case 'vdp'
        mySS = {@f3,@g,@u3,[0;0]'}; % DS 3: Van der Pol, x0 = [0 0]      
    otherwise
      error('oops');
  end
end

function h = verifyLTI
% h = VERIFyLTI Uses the LTI system to verify that your integration
% schemes are working and to compare the results of using Euler, AB-2
% and RK-4. It returns a handle to the resulting plot.

  ic    = 2.0; % initial condition
  tEnd  = 2.0; % end time, s
  tStep = 0.1; % time step, s

  % DS 1: x' = -4x + u, x0 = 2
  mySS = {@f1,@g,@u0,2.0};   

  % Since all the time steps are the same, we'll just calculate one of
  % them, same for the inputs.
  [t, eu.y, ~] = mySim(mySS,tEnd,tStep,'euler');
  [~, ab.y, ~] = mySim(mySS,tEnd,tStep,'ab2'  );
  [~, rk.y, ~] = mySim(mySS,tEnd,tStep,'rk4'  );

  % Exact solution
  yExact = ic*exp(-4*t);

  % Plot settings
  FS = 14; % font size
  LW =  2; % line width
  
  % In case you have some open figures... these lines will find an
  % available id for the new figure
  figs = findobj('type','figure'); % find all the open figures
  id   = length(figs) + 1;          % create an id for this fig

  % Create a new figure window and axes
  h.fig  = figure(id);

  % Plot the data using zero order hold between points, stairs.
  [euT,euY] = stairs(t,eu.y-yExact);   % create stair data for the outputs
  [abT,abY] = stairs(t,ab.y-yExact);   % create stair data for the outputs
  [rkT,rkY] = stairs(t,rk.y-yExact);   % create stair data for the outputs
  
  % Use a subplot for the exact response and more for each of the error
  % plots. The range is too large to show on one plot.
  h.ax(1) = subplot(4,1,1);
  h.ln(1) = line(t,yExact);grid;
  y.ylb(1) = ylabel('Exact');

  h.ax(2) = subplot(4,1,2);
  h.ln(2) = line(euT,euY);grid;
  y.ylb(2) = ylabel('Euler Error');

  h.ax(3) = subplot(4,1,3);  
  h.ln(3) = line(abT,abY);grid;
  y.ylb(3) = ylabel('AB-2 Error');

  h.ax(4) = subplot(4,1,4);  
  h.ln(4) = line(rkT,rkY);grid;
  y.ylb(4) = ylabel('RK-4 Error');  

  % Format the figure
  for i=1:length(h.ln)
    h.ax(i).FontWeight = 'Bold';
    h.ax(i).FontSize = FS;
    h.ln(i).LineWidth = LW;
  end  

  % Enlarge the figure
  h.fig.Position = [440   233   821   564];

end

function h = plotData(simData,sysName)
% h = PLOTDATA(simData,sysName) creates plots customized to the dynamic
% system given in sysName

  % General Settings

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

  % Customized Plots

  switch lower(sysName)
      case 'lti'
        % Plot the data using zero order hold between points, stairs.
        [x,y]   = stairs(simData.t,simData.y);   % create stair data for the output
        h.ln(1) = line(x,y,'Color','k'); % output
        [x,y]   = stairs(simData.t,simData.u);   % create stair data for the input
        h.ln(2) = line(x,y,'Color','b'); % input

        % Formatting
        grid;  
        h.xlb   = xlabel('Time (s)');
        h.ylb   = ylabel('In and Out');
        h.ttl   = title(sysName);
        h.leg   = legend('y','u');

     case {'ltv','vdp'}

        % Plot the data using zero order hold between points, stairs.
        h.axs(1)= subplot(2,1,1);  
        [x,y]   = stairs(simData.t,simData.u);   % create stair data for the input
        h.ln(1) = line(x,y,'Color','b'); % input 
        grid;
        h.xlb(1)   = xlabel('Time (s)');
        h.ylb(1)   = ylabel('u');
        h.ttl   = title(sysName);
  
        h.axs(2)= subplot(2,1,2);
        [x,y]   = stairs(simData.t,simData.y);   % create stair data for the output
        h.ln(2) = line(x(:,1),y(:,1),'Color','k'); % x1
        h.ln(3) = line(x(:,2),y(:,2),'Color','r'); % 
        grid;
        h.leg   = legend('x_1','x_2');
        h.xlb(2)   = xlabel('Time (s)');
        h.ylb(2)   = ylabel('States');      
    otherwise
      error('oops');
  end  

  % More General Settings
  for i=1:length(h.axs)
    h.axs(i).FontWeight  = 'Bold';
    h.axs(i).FontSize    = FS;
  end

  for i=1:length(h.ln)
    h.ln(i).LineWidth = LW;
  end  

end

function h = compareData(d1,d2,sN)
% h = COMPAREDATA(d1,d2,sN) compares the sN output of the two data
% sets using an error plots. It assumes that both data sets have the same
% end time, but, different time steps.

  % plot settings
  FS = 14; % font size
  LW =  2; % line width

  % In case you have some open figures... these lines will find an
  % available id for the new figure
  figs =  findobj('type','figure'); % find all the open figures
  id   = length(figs) + 1;          % create an id for this fig

  % Create a new figure window and axes
  h.fig   = figure(id);

  % Input data
  h.ax(1) = subplot(2,1,1);
  h.ln(1) = line(d1.t,d1.u);
  h.ylb(1) = ylabel('Input');

  % The time points for the data may have different steps, so, we must make
  % one long data set for each.
  if length(d1.t) > length(d2.t)
      %d1.y = d1.y(:,sN);
      tmpY = interp1(d2.t,d2.y,d1.t,'previous');
      d2.t = d1.t;
      d2.y = tmpY;
  else
      %d1.y = d1.y(:,sN);
      tmpY = interp1(d1.t,d1.y,d2.t,'previous');
      d1.t = d2.t;
      d1.y = tmpY;      
  end

  h.ax(2) = subplot(2,1,2);
  % Plot the data using zero order hold between points, stairs.
  [x,y]   = stairs(d1.t,d1.y(:,sN)-d2.y(:,sN));   % create stair data for the output
  h.ln(2) = line(x,y,'Color','k'); % output

  % Formatting
  grid;  
  h.xlb   = xlabel('Time (s)');
  h.ylb   = ylabel('Difference');

  for i=1:length(h.ln)
    h.ln(i).LineWidth = LW;
    h.ax(i).FontWeight = 'Bold';
    h.ax(i).FontSize = FS;    
  end  
end