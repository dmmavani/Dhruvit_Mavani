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
k = round(linspace(1,length(t),35));

% Initialize the variables for loop
xR_i = zeros(1,length(k));
yR_i = zeros(1,length(k));
zR_i = zeros(1,length(k));
x_i = zeros(11,length(k));
y_i = zeros(11,length(k));
z_i = zeros(11,length(k));

% frame capturing
figure
for i = 1:length(k)
    x_i(:,i) = x(:,k(i));
    y_i(:,i) = y(:,k(i));
    z_i(:,i) = z(:,k(i));
    xR_i(:,i) = xR(:,k(i));
    yR_i(:,i) = yR(:,k(i));
    zR_i(:,i) = zR(:,k(i));

    % Plot
    clf
    plot(x_i,z_i,'-o','Color','b','MarkerSize',4,'MarkerFaceColor','#D9FFFF')
    hold on
    plot(xR_i,zR_i,'square','Color','r','MarkerSize',10,'MarkerEdgeColor','auto','LineWidth',2,'MarkerFaceColor',"#EDB120")
    hold off
    grid on
    xlabel('North (m)')
    ylabel('Down (m)')
    xlim([-12 7])
    ylim([0 30])
    set(gca,'YDir','reverse')
    title('Tether-ROV Interaction')
    % zlabel('Down (m)')
    
    

    % Animation
     pause(0.1)
     frame(i) = getframe(gcf);

end

% save video
video = VideoWriter('tether_ROV_interaction_2D','MPEG-4');
video.FrameRate = 2;
open(video);
writeVideo(video,frame);
close(video);

