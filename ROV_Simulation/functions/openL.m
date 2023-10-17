function Tau = openL(thrust)
motion = thrust.motion;
amount = thrust.amount;

if motion == "surge"
    Tau = [85*(amount/100),0,0,0,0,0]';
end

if motion == "sway"
    Tau = [0,85*(amount/100),0,0,0,0]';
end

if motion == "heave"
    Tau = [0,0,120*(amount/100),0,0,0]';
end

if motion == "roll"
    Tau = [0,0,0,26*(amount/100),0,0]';
end

if motion == "pitch"
    Tau = [0,0,0,0,14*(amount/100),0]';
end

if motion == "yaw"
    Tau = [0,0,0,0,0,22*(amount/100)]';
end
end