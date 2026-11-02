-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v5 = {};
local v6 = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v7 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v8 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v9 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v10 = require(l_ReplicatedStorage_0.Packages.Spring);
local v11 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = require(l_ReplicatedStorage_0.Packages.Shake);
local v13 = require(l_ReplicatedStorage_0.Packages.Net);
local v14 = require(l_ReplicatedStorage_0.Shared.VFX);
local v15 = v13:RemoteEvent("EventService/RainingTacos/Shoot");
local l_Name_0 = script.Name;
local v17 = v11.new();
local _ = workspace.CurrentCamera;
@native
local function _(v19, v20, v21, v22) --[[ Line: 27 ]] --[[ Name: quadBezier ]]
    return (1 - v19) ^ 2 * v20 + (1 - v19) * 2 * v19 * v21 + v19 ^ 2 * v22;
end;
v5.OnStart = function(_) --[[ Line: 31 ]] --[[ Name: OnStart ]]
    -- upvalues: v8 (copy), l_Name_0 (copy), l_ReplicatedStorage_0 (copy), v17 (copy), v7 (copy), v9 (copy), v10 (copy), l_RunService_0 (copy), v15 (copy), v6 (copy), v14 (copy)
    assert((v8:GetActiveEventData(l_Name_0)));
    l_ReplicatedStorage_0:SetAttribute("RainingTacosEvent", true);
    v17:Add(function() --[[ Line: 36 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref), v7 (ref), v9 (ref)
        l_ReplicatedStorage_0:SetAttribute("RainingTacosEvent", nil);
        v7:UpdateOST();
        v9:Update();
    end);
    v7:UpdateOST();
    v9:Update();
    local v25 = v17:Clone(script.Cannon);
    v25.Parent = workspace;
    local v26 = script.TacoAmbient:Clone();
    v17:Add(function() --[[ Line: 49 ]]
        -- upvalues: v26 (copy)
        for _, v28 in v26:GetDescendants() do
            if v28:IsA("ParticleEmitter") then
                v28.Enabled = false;
            end;
        end;
        task.wait(5);
        v26:Destroy();
    end);
    v26:PivotTo(workspace.MapCenter.CFrame + Vector3.new(0, 40, 0, 0));
    v26.Parent = workspace;
    local v29 = v25.Top["Meshes/tacolauncher_Cube.004"]["Meshes/tacolauncher_Cube.003"];
    local v30 = v25.Bottom.RootPart["Meshes/tacolauncher_Cube.004"];
    local v31 = v10.new(0);
    v31.Speed = 6.5;
    v31.Damper = 0.85;
    local v32 = v10.new(0);
    v32.Speed = 9;
    v32.Damper = 0.6;
    v17:Add(l_RunService_0.PostSimulation:Connect(function(_) --[[ Line: 75 ]]
        -- upvalues: v29 (copy), v31 (copy), v30 (copy), v32 (copy)
        debug.profilebegin("Raining Tacos Cannon Spring");
        v29.C1 = CFrame.new(v31.Position, 0, 0);
        v30.C1 = CFrame.Angles(0, 0, -math.rad(v32.Position));
        debug.profileend();
    end));
    v17:Add(v15.OnClientEvent:Connect(function(v34, v35) --[[ Line: 82 ]]
        -- upvalues: v6 (ref), v7 (ref), l_ReplicatedStorage_0 (ref), v25 (copy), v32 (copy), v31 (copy), l_RunService_0 (ref), v14 (ref)
        local v36 = v6:GetAnimals()[v34];
        if not v36 then
            return;
        else
            local _ = function() --[[ Line: 88 ]] --[[ Name: getTargetPosition ]]
                -- upvalues: v36 (copy)
                local _ = nil;
                local l_AnimalModel_0 = v36.AnimalModel;
                return (if l_AnimalModel_0.PrimaryPart then l_AnimalModel_0.PrimaryPart.CFrame else l_AnimalModel_0:GetPivot()).Position + Vector3.new(0, v36.AnimalModel:GetExtentsSize().Y * 0.5, 0);
            end;
            local v40 = script.Taco:Clone();
            v40.Parent = workspace;
            task.spawn(function() --[[ Line: 104 ]]
                -- upvalues: v7 (ref), l_ReplicatedStorage_0 (ref), v25 (ref)
                v7:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Raining Tacos"].Shoot, v25:GetPivot().Position);
            end);
            task.spawn(function() --[[ Line: 108 ]]
                -- upvalues: v32 (ref), v31 (ref)
                v32:Impulse(650);
                task.wait(0.05);
                v31:Impulse(35);
            end);
            local l_Position_0 = v25.ShootPart.CFrame.Position;
            local v42 = nil;
            v42 = l_RunService_0.PreRender:Connect(function() --[[ Line: 117 ]]
                -- upvalues: v36 (copy), l_Position_0 (copy), v35 (copy), v40 (copy), v42 (ref), v7 (ref), l_ReplicatedStorage_0 (ref), v14 (ref)
                debug.profilebegin("Raining Tacos");
                local v43 = nil;
                local l_AnimalModel_1 = v36.AnimalModel;
                local v45 = (if l_AnimalModel_1.PrimaryPart then l_AnimalModel_1.PrimaryPart.CFrame else l_AnimalModel_1:GetPivot()).Position + Vector3.new(0, v36.AnimalModel:GetExtentsSize().Y * 0.5, 0);
                v43 = l_Position_0 + (v45 - l_Position_0) * 0.5 + Vector3.new(0, 60, 0, 0);
                l_AnimalModel_1 = 1 - (v35 + 2.5 - workspace:GetServerTimeNow()) / 2.5;
                local v46 = math.clamp(l_AnimalModel_1, 0, 1);
                local l_l_Position_0_0 = l_Position_0;
                local v48 = (1 - v46) ^ 2 * l_l_Position_0_0 + (1 - v46) * 2 * v46 * v43 + v46 ^ 2 * v45;
                l_l_Position_0_0 = math.clamp(l_AnimalModel_1, 0, 1) + 0.1;
                local l_l_Position_0_1 = l_Position_0;
                v46 = (1 - l_l_Position_0_0) ^ 2 * l_l_Position_0_1 + (1 - l_l_Position_0_0) * 2 * l_l_Position_0_0 * v43 + l_l_Position_0_0 ^ 2 * v45;
                v40.CFrame = CFrame.lookAt(v48, v46);
                if l_AnimalModel_1 >= 1 then
                    v42:Disconnect();
                    task.spawn(function() --[[ Line: 133 ]]
                        -- upvalues: v7 (ref), l_ReplicatedStorage_0 (ref), v45 (copy)
                        v7:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Raining Tacos"].Hit, v45);
                    end);
                    v40:Destroy();
                    l_l_Position_0_0 = script.StruckVFX:Clone();
                    l_l_Position_0_0:PivotTo(CFrame.new(v45));
                    l_l_Position_0_0.Anchored = false;
                    l_l_Position_0_1 = Instance.new("WeldConstraint");
                    l_l_Position_0_1.Part0 = l_l_Position_0_0;
                    l_l_Position_0_1.Part1 = v36.AnimalModel.PrimaryPart;
                    l_l_Position_0_1.Parent = l_l_Position_0_0;
                    l_l_Position_0_0.Parent = workspace;
                    v14.emit(l_l_Position_0_0);
                    task.delay(3, function() --[[ Line: 153 ]]
                        -- upvalues: l_l_Position_0_0 (copy)
                        l_l_Position_0_0:Destroy();
                    end);
                end;
                debug.profileend();
            end);
            return;
        end;
    end));
end;
v5.OnStop = function(_) --[[ Line: 163 ]] --[[ Name: OnStop ]]
    -- upvalues: v17 (copy)
    v17:Destroy();
end;
v5.OnLoad = function(_) --[[ Line: 167 ]] --[[ Name: OnLoad ]]

end;
return v5;