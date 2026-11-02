local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local v7 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v8 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v9 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v10 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v11 = require(l_ReplicatedStorage_0.Packages.Observers);
local v12 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v13 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = require(l_ReplicatedStorage_0.Packages.Spr);
local _ = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local v17 = v13.new();
v6.OnStart = function(_)
    assert((v9:GetActiveEventData(l_Name_0)));
    local l_Atmosphere_0 = l_Lighting_0:FindFirstChild("Atmosphere");
    if l_Atmosphere_0 then
        l_Atmosphere_0.Parent = script;
        v17:Add(function()
            l_Atmosphere_0.Parent = l_Lighting_0;
        end);
    end;
    v17:Clone(script.AtmosphereCursed).Parent = l_Lighting_0;
    local l_Cartoon_0 = l_Lighting_0:FindFirstChild("Cartoon");
    if l_Cartoon_0 then
        l_Cartoon_0.Parent = script;
        v17:Add(function()
            l_Cartoon_0.Parent = l_Lighting_0;
        end);
    end;
    v17:Clone(script.SkyCursed).Parent = l_Lighting_0;
    local v21 = true;
    v17:Add(function()
        v21 = false;
    end);
    v7:Activate("Blink");
    v17:Add(function()
        v7:Activate("Blink");
    end);
    v7:Run("CursedEvent", "GrassRecolor");
    v17:Add(function()
        v7:Stop("CursedEvent", "GrassRecolor");
    end);
    v7:Run("CursedEvent", "WallRecolor");
    v17:Add(function()
        v7:Stop("CursedEvent", "WallRecolor");
    end);
    v7:Run("CursedEvent", "WallBottomRecolor");
    v17:Add(function()
        v7:Stop("CursedEvent", "WallBottomRecolor");
    end);
    if v12.IsTsunamiServer() then
        v17:Clone(script.CursedMapTsunami).Parent = workspace;
    elseif v12.IsBiggerServer() then
        v17:Clone(script.CursedMapBigger).Parent = workspace;
    else
        v17:Clone(script.CursedMap).Parent = workspace;
    end;
    v17:Add(v11.observeTag("HideInCursed", function(v22)
        local l_Parent_0 = v22.Parent;
        v22.Parent = script;
        return function()
            pcall(function()
                v22.Parent = l_Parent_0;
            end);
        end;
    end, {
        workspace, 
        script
    }));
    v10:Update();
    v8:UpdateOST();
end;
v6.OnStop = function(_)
    v17:Destroy();
end;
v6.OnLoad = function(_)

end;
return v6;
