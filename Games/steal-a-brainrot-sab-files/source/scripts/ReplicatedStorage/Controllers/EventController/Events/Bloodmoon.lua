

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v8 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local _ = require(l_ReplicatedStorage_0.Controllers.EventController);
local v10 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local _ = require(l_ReplicatedStorage_0.Packages.Spring);
local v12 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = require(l_ReplicatedStorage_0.Packages.Shake);
local _ = require(l_ReplicatedStorage_0.Packages.Net);
local _ = script.Name;
local v16 = v12.new();
v6.OnStart = function(_)
    local l_Atmosphere_0 = l_Lighting_0:FindFirstChild("Atmosphere");
    if l_Atmosphere_0 then
        l_Atmosphere_0.Parent = script;
        v16:Add(function()
            l_Atmosphere_0.Parent = l_Lighting_0;
        end);
    end;
    v16:Clone(script.AtmosphereBloodmoon).Parent = l_Lighting_0;
    local l_Cartoon_0 = l_Lighting_0:FindFirstChild("Cartoon");
    if l_Cartoon_0 then
        l_Cartoon_0.Parent = script;
        v16:Add(function()
            l_Cartoon_0.Parent = l_Lighting_0;
        end);
    end;
    v16:Clone(script.SkyBloodmoon).Parent = l_Lighting_0;
    v10:Update();
    v8:UpdateOST();
end;
v6.OnStop = function(_)
    v16:Destroy();
end;
v6.OnLoad = function(_)

end;
return v6;