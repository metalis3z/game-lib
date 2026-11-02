-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
v0.new = function()
    local v1 = setmetatable({}, v0);
    v1.cameras = require(script:WaitForChild("CameraModule"));
    v1.controls = require(script:WaitForChild("ControlModule"));
    return v1;
end;
v0.GetCameras = function(v2)
    return v2.cameras;
end;
v0.GetControls = function(v3)
    return v3.controls;
end;
v0.GetClickToMoveController = function(v4)
    return v4.controls:GetClickToMoveController();
end;
return v0.new();