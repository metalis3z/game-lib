
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v2 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v3 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v4 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v5 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v6 = require(l_ReplicatedStorage_0.Controllers.WorldBrainrotController);
local v7 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v8 = require(l_ReplicatedStorage_0.Packages.Observers);
local v9 = require(l_ReplicatedStorage_0.Packages.Spr);
local v10 = require(l_ReplicatedStorage_0.Packages.Trove);
local v11 = require(script.EggVisuals);
local l_Name_0 = script.Name;
local v13 = {};
local v14 = v10.new();
v13.OnStart = function(_)
    assert((v2:GetActiveEventData(l_Name_0)));
    v14:Add(function()
        v5:Activate("Blink");
        v3:Update();
        v4:UpdateOST();
        v4:UpdateAmbience();
    end);
    v5:Activate("Blink");
    v3:Update();
    v4:UpdateOST();
    v4:UpdateAmbience();
    v5:Run("EggCityEvent", "GrassRecolor");
    v14:Add(function()
        v5:Stop("EggCityEvent", "GrassRecolor");
    end);
    v5:Run("EggCityEvent", "WallRecolor");
    v14:Add(function()
        v5:Stop("EggCityEvent", "WallRecolor");
    end);
    v5:Run("EggCityEvent", "WallBottomRecolor");
    v14:Add(function()
        v5:Stop("EggCityEvent", "WallBottomRecolor");
    end);
    v14:Add(v8.observeTag("HideInEggCity", function(v16)
        local l_Parent_0 = v16.Parent;
        v16.Parent = script;
        return function()
            v16.Parent = l_Parent_0;
        end;
    end));
    v14:Add(v8.observeTag("EggCityDoor", function(v18)
        local l_v18_Pivot_0 = v18:GetPivot();
        return v8.observeAttribute(v18, "Open", function(v20)
            if not v20 then
                v9.target(v18, 0.75, 3.5, {
                    Pivot = l_v18_Pivot_0
                });
            else
                v9.target(v18, 0.75, 3.5, {
                    Pivot = l_v18_Pivot_0 * CFrame.Angles(0, 1.5707963267948966, 0)
                });
            end;
            return nil;
        end);
    end));
    if v7.IsBiggerServer() then
        v14:Clone(script.EggCityMapBigger).Parent = workspace;
    else
        v14:Clone(script.EggCityMap).Parent = workspace;
    end;
    v14:Add(v11:Start());
    v14:Add(v6:RenderPool({
        PoolId = "EggCity/Brainrots", 
        ReplicatorId = "EggCity/Brainrots", 
        ShowTimer = true, 
        ShowDropButton = true, 
        GrabHoldDuration = 2, 
        GrabMaxDistance = 10
    }));
    return nil;
end;
v13.OnStop = function(_)
    v14:Destroy();
end;
v13.OnLoad = function(_)

end;
return v13;