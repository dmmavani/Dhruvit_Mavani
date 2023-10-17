clear
close('all')
clc

%% Data to be loaded
    data.pos_tether = "data\tether\pos_tether.mat";     % Position of tether
    data.pos_ROV_N = "data\tether\North.mat";           % Position of ROV in NORTH direction
    data.pos_ROV_E = "data\tether\East.mat";            % Position of ROV in EAST direction
    data.pos_ROV_D = "data\tether\Down.mat";            % Position of ROV in DOWN direction   

%% Load data
load(data.pos_tether);
load(data.pos_ROV_N);
load(data.pos_ROV_D);
load(data.pos_ROV_E);

% position of tether in x and z-direction
t = [squeeze(pos.Time)]';
xt = squeeze(pos.Data(1,:,:));
yt = squeeze(pos.Data(2,:,:));
zt = squeeze(pos.Data(3,:,:));

% position of ROV in North and Down direction
xR = N(2,:);
yR = E(2,:);
zR = D(2,:);

% overall position
x = [xt;xR];
y = [yt;yR];
z = [zt;zR];

%% PLotting

% Define no of samples to be used
k = length(t);

% Initialize the variables for loop
n_i = zeros(1,k);
xR_i = zeros(1,k);
yR_i = zeros(1,k);
zR_i = zeros(1,k);
x_i = zeros(11,k);
y_i = zeros(11,k);
z_i = zeros(11,k);

% frame capturing
figure
for i = 1:length(t)
    n_i(:,i) = t(:,i);
    x_i(:,i) = x(:,i);
    y_i(:,i) = y(:,i);
    z_i(:,i) = z(:,i);
    xR_i(:,i) = xR(:,i);
    yR_i(:,i) = yR(:,i);
    zR_i(:,i) = zR(:,i);

    % Plot
    clf
    plot3(x_i,y_i,z_i,'-o','Color','b','MarkerSize',4,'MarkerFaceColor','#D9FFFF')
    set(gca,'ZDir','reverse')
    hold on
    plot3(xR_i,yR_i,zR_i,'square','Color','r','MarkerSize',10,'MarkerEdgeColor','auto','LineWidth',2,'MarkerFaceColor',"#EDB120")
    grid on
    xlabel('North (m)')
    ylabel('East (m)')
    zlabel('Down (m)')
    title('Tether-ROV Interaction')
    xlim([-12 7])

    % Animation
     pause(0.1)
     
end

% % save video
% video = VideoWriter('tether_ROV_interaction_3D','MPEG-4');
% video.FrameRate = 2;
% open(video);
% writeVideo(video,frame);
% close(video);

