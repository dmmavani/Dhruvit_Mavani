function Vd = pDD(t,x,ext,phy)



N = ext.tether.N;    
E = ext.tether.E;
m = ext.tether.m;
l = ext.tether.lc;
l0 = ext.tether.l0;
rho = phy.rho;
Cint = ext.tether.Cint;
Cn = ext.tether.Cn;
Ct = ext.tether.Ct;
dt = ext.tether.d;

xstate = reshape(x,3,[]);
% let define state vector
    p0 = zeros(3,1);      % position of first node
    pn = [0,0,15]';     % position of last node (attached to ROV)
    pr = xstate(1:N-2);      % position of remaining nodes 
    v0 = zeros(3,1);
    vr = xstate(N-1:2*(N-2));
    vc = zeros(3,1);
    
% Mass matrix
M = (((m*l)/N) + (pi/4)*dt^2*l0*rho) .* ones(3,1); 

%% Internal damping
    Pi = zeros(3,N-2);      % Internal Damping
    for i = 1:N-2
        if i==1
            Pi(:,i) = ((Cint).*(vr(:,i) - v0) .* (pr(:,i+1)-pr(:,i))).*(((pr(:,i+1)-pr(:,i))./norm(abs((pr(:,i+1)-pr(:,i))))));
        elseif (i>1)&&(i<N-2)
            Pi(:,i) = ((Cint).*(vr(:,i) - vr(:,i-1)) .* (pr(:,i+1)-pr(:,i))) .* (((pr(:,i+1)-pr(:,i))./norm(abs((pr(:,i+1)-pr(:,i))))));
        elseif i == N-2
            Pi(:,i) = ((Cint).*(vr(:,i) - vr(:,i-1)) .* (pn - pr(:,i))).*((pn - pr(:,i))./norm(abs((pn - pr(:,i)))));
        end
    end
    P1 = ((Cint) * (v0) .* (pr(:,1) - p0)) .* ((pr(:,1) - p0) ./norm(abs((pr(:,1) - p0))));
%% Hydrodynamic forces
    % Normal and Tangential velocity component
    Vt = zeros(3,N-2);
    for i = 1:N-2
        if i<N-2
            Vt(:,i) = (vc - vr(:,i)).* ((pr(:,i+1)-pr(:,i)).^2 ./ norm(abs(pr(:,i+1)-pr(:,i))));
        else
            Vt(:,i) = (vc - vr(:,i)).* ((pn - pr(:,i)).^2 ./ norm(abs(pn - pr(:,i))));
        end
    end

    Vn = zeros(3,N-2);
    for i = 1:N-2
        Vn(:,i) = vc - vr(:,i) - Vt(:,i);
    end

    % Normal and tangential force component
    Fn = zeros(3,N-2);
    for i =1:N-2
        if i<N-2
            Fn(:,i) = 0.5*rho*dt*Cn* Vn(:,i).* abs(Vn(:,i)).* norm(abs(pr(:,i+1)-pr(:,i)));
        else
            Fn(:,i) = 0.5*rho*dt*Cn* Vn(:,i).* abs(Vn(:,i)).* norm(abs(pn - pr(:,i)));
        end
    end

    Ft = zeros(3,N-2);
    for i =1:N-2
        if i<N-2
            Ft(:,i) = 0.5*rho*dt*Ct* Vt(:,i).* abs(Vt(:,i)).* norm(abs(pr(:,i+1)-pr(:,i)));
        else
            Ft(:,i) = 0.5*rho*dt*Ct* Vt(:,i).* abs(Vt(:,i)).* norm(abs(pn - pr(:,i)));
        end
    end

    % Total hydrodynamic forces
    F = zeros(3,N-2);
    for i = 1:N-2
        F(:,i) = Fn(:,i) + Ft(:,i);
    end
        
%% Tension in N nodes
    T = zeros(3,N-2);
    for i = 1:N-2
        if i<N-2
            T(:,i) = E*(((3.14/4)*dt.^2)./l0) .* (pr(:,i+1)-pr(:,i)) .* ((l0./norm(abs(pr(:,i+1) - pr(:,i)))) - 1);
        elseif i==N-2
            T(:,i) = E*(((3.14/4)*dt.^2)./l0) .* (pn - pr(:,i)) .* ((l0./norm(abs(pn - pr(:,i)))) - 1);
        end
    end
   
    T1 = E*(((pi/4)*dt.^2)./l0) .* (pr(:,1) - p0) .* ((l0./norm(abs(pr(:,1) - p0))) - 1);
%% Equation of motion
    vd = zeros(3,N-2);
    for i=1:N-2
        if i==1
            vd(:,i) = -((P1 - Pi(:,i) + F(:,i)) - (T(:,i) - T1))./M;
        elseif i>1
            vd(:,i) = -((Pi(:,i-1) - Pi(:,i) + F(:,i)) + (T(:,i) - T(:,i-1)))./M;
        end
    end

    Vd = [reshape(vr,[],1);reshape(vd,[],1)];


