function xDot = f3(x,u,t)
mu = 8.53;
xDot = [x(2) mu*(1-x(1)^2)*x(2)-x(1)+u(1)];
end
