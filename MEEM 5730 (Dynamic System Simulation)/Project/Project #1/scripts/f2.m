function xDot = f2(x,u,t)
% Given Parameters
m = 1;
c = 0.5;
k = 30 + 3*sin(2*pi*t);

% State derivatives
xDot = [x(2), -k/m*x(1)-c/m*x(2)+u(2)/m];
end
