clear
close('all')
clc

%% Data to be loaded
    data.pos_tether = "data\tether\pos_tether.mat";     % Position of tether
    data.pos_ROV_N = "data\tether\North.mat";           % Position of ROV in NORTH direction
    data.pos_ROV_D = "data\tether\Down.mat";            % Position of ROV in DOWN direction   

%% Load data
load(data.pos_tether);
load(data.pos_ROV_N);
load(data.pos_ROV_D);

% position of tether in x and z-direction
xt = squeeze(pos.Data(1,:,:));
zt = squeeze(pos.Data(3,:,:));

% position of ROV in North and Down direction
xR = N(2,:);
zR = D(2,:);

% overall position
x = [xt;xR];
z = [zt;zR];

%% PLotting

% Define no of samples to be used
n = 1:4980:119526;
k = length(n);

% Initialize the variables for loop
n_i = zeros(1,k);
xt_i = zeros(10,k);
zt_i = zeros(10,k);
xR_i = zeros(1,k);
zR_i = zeros(1,k);
x_i = zeros(11,k);
z_i = zeros(11,k);

% frame capturing
figure
for i = 1:length(n)
    n_i(:,i) = n(:,i);
    x_i(:,i) = x(:,n_i(:,i));
    z_i(:,i) = z(:,n_i(:,i));
    xR_i(:,i) = xR(:,n_i(:,i));
    zR_i(:,i) = zR(:,n_i(:,i));

    % Plot
    clf
    plot(x_i,z_i,'-o','Color','b','MarkerSize',4,'MarkerFaceColor','#D9FFFF')
    set(gca,'YDir','reverse')
    hold on
    plot(xR_i,zR_i,'square','Color','r','MarkerSize',10,'MarkerEdgeColor','auto','LineWidth',2,'MarkerFaceColor',"#EDB120")
    grid on
    xlabel('North (m)')
    ylabel('Down (m)')
    title('Tether-ROV Interaction')
   
    % Animation
     pause(1)
     frame(:,i) = getframe(gcf);
end

% save video
video = VideoWriter('tether_ROV_interaction','MPEG-4');
video.FrameRate = 2;
open(video);
writeVideo(video,frame);
close(video);

