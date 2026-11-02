

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local v7 = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local _ = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v9 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v10 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v11 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local _ = require(l_ReplicatedStorage_0.Shared.ShakePresets);
local _ = require(l_ReplicatedStorage_0.Packages.Observers);
local v14 = require(l_ReplicatedStorage_0.Packages.Trove);
local v15 = require(l_ReplicatedStorage_0.Packages.Net);
local v16 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local v18 = v15:RemoteEvent("EventService/Rain/Hit");
local v19 = v14.new();
v6.OnStart = function(_)
    local l_v10_ActiveEventData_0 = v10:GetActiveEventData(l_Name_0);
    assert(l_v10_ActiveEventData_0);
    l_ReplicatedStorage_0:SetAttribute("Rain", true);
    v19:Add(function()
        l_ReplicatedStorage_0:SetAttribute("Rain", nil);
    end);
    local function _(v22, v23)
        return l_v10_ActiveEventData_0.startedAt + v22 - (v23 or workspace:GetServerTimeNow());
    end;
    local v25 = l_v10_ActiveEventData_0.startedAt + 4 - workspace:GetServerTimeNow();
    local v26 = v19:Clone(script.RainWeather);
    v16.disable(v26);
    v26.Parent = workspace;
    v19:Add(task.delay(v25, function()
        local l_Atmosphere_0 = l_Lighting_0:FindFirstChild("Atmosphere");
        if l_Atmosphere_0 then
            l_Atmosphere_0.Parent = script;
            v19:Add(function()
                l_Atmosphere_0.Parent = l_Lighting_0;
            end);
        end;
        v19:Clone(script.AtmosphereRain).Parent = l_Lighting_0;
        local l_Cartoon_0 = l_Lighting_0:FindFirstChild("Cartoon");
        if l_Cartoon_0 then
            l_Cartoon_0.Parent = script;
            v19:Add(function()
                l_Cartoon_0.Parent = l_Lighting_0;
            end);
        end;
        v19:Clone(script.SkyRain).Parent = l_Lighting_0;
        v16.enable(v26);
    end));
    v11:Update();
    v9:UpdateOST();
    v9:UpdateAmbience();
end;
v6.OnStop = function(_)
    v19:Destroy();
end;
v6.OnLoad = function(_)
    v18.OnClientEvent:Connect(function(v31)
        local v32 = nil;
        local v33 = nil;
        if type(v31) == "string" then
            local v34 = v7:GetAnimals()[v31];
            if not v34 then
                return;
            else
                local l_v34_0 = v34 ;
                local _ = function()
                    local _ = nil;
                    local l_AnimalModel_0 = l_v34_0.AnimalModel;
                    return (if l_AnimalModel_0.PrimaryPart then l_AnimalModel_0.PrimaryPart.CFrame else l_AnimalModel_0:GetPivot()).Position + Vector3.new(0, l_v34_0.AnimalModel:GetExtentsSize().Y * 0.5, 0);
                end;
                local _ = nil;
                local l_AnimalModel_1 = v34.AnimalModel;
                v32 = (if l_AnimalModel_1.PrimaryPart then l_AnimalModel_1.PrimaryPart.CFrame else l_AnimalModel_1:GetPivot()).Position + Vector3.new(0, v34.AnimalModel:GetExtentsSize().Y * 0.5, 0);
                v33 = v34.AnimalModel.PrimaryPart;
            end;
        else
            v32 = v31:GetPivot().Position;
            v33 = v31;
        end;
        v9:PlaySound(l_ReplicatedStorage_0.Sounds.Events.Rain.Burst, v32);
        local v41 = script.StruckVFX:Clone();
        v41:PivotTo(CFrame.new(v32));
        v41.Anchored = false;
        local l_WeldConstraint_0 = Instance.new("WeldConstraint");
        l_WeldConstraint_0.Part0 = v41;
        l_WeldConstraint_0.Part1 = v33;
        l_WeldConstraint_0.Parent = v41;
        v41.Parent = workspace;
        v16.emit(v41);
        task.delay(3, function()
            v41:Destroy();
        end);
    end);
end;
return v6;