-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_Builderman_0 = l_ReplicatedStorage_0.Assets.Survivors.Builderman;
local v4 = require(script:FindFirstAncestor("HallucinationClass"));
local v5 = require(l_Builderman_0.Config);
local v6 = require(l_ReplicatedStorage_0.Modules.Util);
local v7 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v8 = require(l_ReplicatedStorage_0.Modules.Actors);
local v9 = {
    ApplyAt = 2, 
    Condition = function() --[[ Line: 20 ]]
        if workspace.Players.Survivors:FindFirstChild("Builderman") then
            return true;
        else
            return false;
        end;
    end
};
v9.__index = v9;
setmetatable(v9, v4);
local function v17() --[[ Line: 26 ]] --[[ Name: findBuilderman ]]
    -- upvalues: l_Players_0 (copy), v8 (copy), v5 (copy)
    local l_Children_0 = workspace.Players.Survivors:GetChildren();
    local l_ipairs_0 = ipairs;
    local v12 = l_Children_0 or {};
    for _, v14 in l_ipairs_0(v12) do
        if v14.Name == "Builderman" then
            local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v14);
            local v16 = l_l_Players_0_PlayerFromCharacter_0 and v8.CurrentActors[l_l_Players_0_PlayerFromCharacter_0];
            if v16 and v16.Config then
                return v16.Config;
            end;
        end;
    end;
    return v5;
end;
v9.new = function(...) --[[ Line: 43 ]] --[[ Name: new ]]
    -- upvalues: v4 (copy), v9 (copy)
    return (setmetatable(v4.new(...), v9));
end;
v9.Init = function(v18) --[[ Line: 49 ]] --[[ Name: Init ]]
    -- upvalues: v17 (copy), v7 (copy), l_TweenService_0 (copy), v6 (copy)
    v18.Dispensers = {};
    task.delay(math.random(1, 3), function() --[[ Line: 52 ]]
        -- upvalues: v18 (copy), v17 (ref), v7 (ref), l_TweenService_0 (ref), v6 (ref)
        if not v18 or not v18.Running then
            return;
        else
            local v19 = v17();
            local v20 = v19.DispenserTemplate:Clone();
            local l_v18_RandomSpawnInCone_0 = v18:GetRandomSpawnInCone(v18.Survivor.Rig.PrimaryPart.Position, NumberRange.new(120, 240), 90, 7, 0.8);
            local v22 = RaycastParams.new();
            v22.FilterType = Enum.RaycastFilterType.Exclude;
            v22.FilterDescendantsInstances = {
                v20, 
                workspace.Players
            };
            local v23 = workspace:Raycast(l_v18_RandomSpawnInCone_0, Vector3.new(0, -100, 0, 0), v22);
            local v24 = (v23 and v23.Position or l_v18_RandomSpawnInCone_0) + Vector3.new(0, v20.PrimaryPart.Size.Y / 2, 0);
            v20:SetPrimaryPartCFrame(CFrame.new(v24));
            v20.Parent = workspace.Map.Ingame;
            local v25 = v7:Play(v19.Sounds.DispenserIdle, {
                Parent = v20.PrimaryPart, 
                RollOffMaxDistance = 40, 
                RollOffMinDistance = 1
            });
            local l_Volume_0 = v25.Volume;
            v25.Volume = 0;
            l_TweenService_0:Create(v25, TweenInfo.new(1), {
                Volume = l_Volume_0
            }):Play();
            task.spawn(function() --[[ Line: 75 ]]
                -- upvalues: v6 (ref), v20 (copy), v19 (copy)
                v6:LoadAnimationFromID(v20, v19.DispenserAnimations.Idle, true):Play();
            end);
            for _, v28 in pairs(v20:GetDescendants()) do
                if (v28:IsA("ParticleEmitter") or v28:IsA("Light")) and v28.Name ~= "Shoot" then
                    v28.Enabled = true;
                end;
            end;
            local l_v6_ClosestPlayerFromPosition_0 = v6:GetClosestPlayerFromPosition(v24, {
                MaxDistance = v19.DispenserPingDistance, 
                ReturnTable = true
            });
            for _, v31 in pairs(l_v6_ClosestPlayerFromPosition_0) do
                local l_Player_0 = v31.Player;
                if game.Players:GetPlayerFromCharacter(l_Player_0) then
                    v6:RevealPlayerAura(v20, v19.DispenserPingDuration, Color3.new(0.75, 1, 0.75));
                end;
            end;
            local l_Rig_0 = v18.Survivor.Rig;
            local _ = l_Rig_0.PrimaryPart;
            local l_Humanoid_0 = l_Rig_0.Humanoid;
            task.spawn(function() --[[ Line: 102 ]]
                -- upvalues: v18 (ref), v20 (copy), l_Rig_0 (copy), l_Humanoid_0 (copy), v19 (copy)
                while true do
                    if v18 and v18.Running then
                        local v36 = game["Run Service"].Heartbeat:Wait();
                        if not v18 or not v18.Running then
                            return;
                        elseif not v20.Parent then
                            return;
                        elseif not v20.PrimaryPart then
                            return;
                        elseif not l_Rig_0 or not l_Humanoid_0 then
                            return;
                        else
                            local l_DispenserHealingPerSec_0 = v19.DispenserHealingPerSec;
                            if (v18.Survivor.Rig.PrimaryPart.Position - v20.PrimaryPart.Position).Magnitude <= v19.DispenserHealingRadius / 2 then
                                local _ = l_Humanoid_0.MaxHealth - l_Humanoid_0.Health;
                                l_Humanoid_0:SetAttribute("FakeDamage", (l_Humanoid_0:GetAttribute("FakeDamage") or 0) - l_DispenserHealingPerSec_0 * v36);
                            end;
                        end;
                    else
                        return;
                    end;
                end;
            end);
            table.insert(v18.Dispensers, v20);
            return;
        end;
    end);
end;
v9.Destroy = function(v39) --[[ Line: 130 ]] --[[ Name: Destroy ]]
    -- upvalues: v7 (copy)
    local l_ipairs_1 = ipairs;
    local v41 = v39.Dispensers or {};
    for _, v43 in l_ipairs_1(v41) do
        local v44 = Instance.new("Attachment", workspace.Terrain);
        v44.WorldPosition = v43.PrimaryPart.Position;
        game.Debris:AddItem(v44, 5);
        v7:Play(v39:GetKillerConfig().Sounds.HallucinationDispenserDeath, {
            Parent = v44
        });
        v43:Destroy();
    end;
    v39.Running = false;
    v39:Clean();
end;
return v9;