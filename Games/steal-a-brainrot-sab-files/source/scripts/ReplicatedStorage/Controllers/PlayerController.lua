-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local l_RunService_0 = game:GetService("RunService");
local v1 = 0;
return {
    GetFps = function(_)
        return v1;
    end, 
    Start = function(_)
        l_RunService_0.RenderStepped:Connect(function(v4)
            debug.profilebegin("PlayerController");
            v1 = math.floor(1 / v4);
            debug.profileend();
        end);
    end
};