function VC_MODE = Vc(oceancurrents)
if oceancurrents == "constant"
    VC_MODE = 2;
elseif oceancurrents == "random"
    VC_MODE = 1;
end