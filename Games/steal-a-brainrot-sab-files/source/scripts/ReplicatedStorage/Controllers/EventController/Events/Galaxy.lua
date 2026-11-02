

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local v7 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v8 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v9 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v10 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v11 = require(l_ReplicatedStorage_0.Packages.Observers);
local v12 = require(l_ReplicatedStorage_0.Packages.Trove);
local l_Name_0 = script.Name;
local l_UFO_0 = l_ReplicatedStorage_0.Models.Events.UFO.UFO;
local v15 = v12.new();
local _ = function()
    local v16 = v15:Extend();
    v16:Add(v11.observeTag("GalaxyUFO", function(v17)
        if not v17:IsA("BasePart") then
            return nil;
        else
            local v18 = v16:Extend();
            local v19 = v18:Clone(l_UFO_0);
            for _, v21 in v19:GetDescendants() do
                if v21:IsA("BasePart") then
                    v21.Anchored = true;
                end;
            end;
            v19.Parent = workspace;
            v18:Add(l_RunService_0.PostSimulation:Connect(function()
                debug.profilebegin("Galaxy:MoveUFO");
                if v19.PrimaryPart and v17.Parent then
                    v19:PivotTo(v17.CFrame);
                else
                    v18:Destroy();
                end;
                debug.profileend();
            end));
            return function()
                v18:Destroy();
            end;
        end;
    end));
end;
v6.OnStart = function(_)
    assert((v9:GetActiveEventData(l_Name_0)));
    local l_Atmosphere_0 = l_Lighting_0:FindFirstChild("Atmosphere");
    if l_Atmosphere_0 then
        l_Atmosphere_0.Parent = script;
        v15:Add(function()
            l_Atmosphere_0.Parent = l_Lighting_0;
        end);
    end;
    v15:Clone(script.AtmosphereGalaxy).Parent = l_Lighting_0;
    local l_Cartoon_0 = l_Lighting_0:FindFirstChild("Cartoon");
    if l_Cartoon_0 then
        l_Cartoon_0.Parent = script;
        v15:Add(function()
            l_Cartoon_0.Parent = l_Lighting_0;
        end);
    end;
    v15:Clone(script.SkyGalaxy).Parent = l_Lighting_0;
    v7:Run("GalaxyEvent", "GrassRecolor");
    v15:Add(function()
        v7:Stop("GalaxyEvent", "GrassRecolor");
    end);
    v7:Run("GalaxyEvent", "WallRecolor");
    v15:Add(function()
        v7:Stop("GalaxyEvent", "WallRecolor");
    end);
    v15:Clone(script.GalaxyMap).Parent = workspace;
    v15:Add(v11.observeTag("HideInGalaxy", function(v26)
        local l_Parent_0 = v26.Parent;
        v26.Parent = script;
        return function()
            pcall(function()
                v26.Parent = l_Parent_0;
            end);
        end;
    end, {
        workspace, 
        script
    }));
    local v28 = script.GalaxyWeather:Clone();
    v28.Parent = workspace;
    v15:Add(function()
        for _, v30 in v28:GetDescendants() do
            if v30:IsA("ParticleEmitter") then
                v30.Enabled = false;
            end;
        end;
        task.wait(4);
        v28:Destroy();
    end);
    v10:Update();
    v8:UpdateOST();
    local v31 = v15:Extend();
    v31:Add(v11.observeTag("GalaxyUFO", function(v32)
        if not v32:IsA("BasePart") then
            return nil;
        else
            local v33 = v31:Extend();
            local v34 = v33:Clone(l_UFO_0);
            for _, v36 in v34:GetDescendants() do
                if v36:IsA("BasePart") then
                    v36.Anchored = true;
                end;
            end;
            v34.Parent = workspace;
            v33:Add(l_RunService_0.PostSimulation:Connect(function()
                debug.profilebegin("Galaxy:MoveUFO");
                if v34.PrimaryPart and v32.Parent then
                    v34:PivotTo(v32.CFrame);
                else
                    v33:Destroy();
                end;
                debug.profileend();
            end));
            return function()
                v33:Destroy();
            end;
        end;
    end));
end;
v6.OnStop = function(_)
    v15:Destroy();
end;
v6.OnLoad = function(_)

end;
return v6;