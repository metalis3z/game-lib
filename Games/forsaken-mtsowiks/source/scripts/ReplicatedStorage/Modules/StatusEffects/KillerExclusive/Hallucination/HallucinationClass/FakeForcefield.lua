-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FakeForcefield, time of decompilation: Fri Nov 28 21:06:22 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_Dusekkar_0 = l_ReplicatedStorage_0.Assets.Survivors.Dusekkar;
local v4 = require(script:FindFirstAncestor("HallucinationClass"));
local v5 = require(l_Dusekkar_0.Config);
local v6 = require(l_ReplicatedStorage_0.Modules.Util);
local v7 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v8 = require(l_ReplicatedStorage_0.Modules.Actors);
local v9 = {
    ApplyAt = 2, 
    Condition = function() --[[ Line: 21 ]]
        if workspace.Players.Survivors:FindFirstChild("Dusekkar") then
            return true;
        else
            return false;
        end;
    end
};
v9.__index = v9;
setmetatable(v9, v4);
local function v17(v10, v11, v12, v13) --[[ Line: 27 ]] --[[ Name: playVFX ]]
    local v14 = v10.VFXTemplate[v12]:Clone();
    v14.Parent = v11;
    if v13 then
        game.Debris:AddItem(v14, v13);
    end;
    for _, v16 in pairs(v14:GetChildren()) do
        if v16:IsA("ParticleEmitter") then
            v16:Emit(v16:GetAttribute("EmitCount") or 1);
        end;
    end;
    return v14;
end;
local function v21(v18) --[[ Line: 45 ]] --[[ Name: activateVFX ]]
    for _, v20 in pairs(v18:GetChildren()) do
        if v20:IsA("ParticleEmitter") then
            v20:Emit(v20:GetAttribute("EmitCount") or 1);
        end;
        v20.Enabled = true;
    end;
end;
local function v29() --[[ Line: 52 ]] --[[ Name: findDusekkar ]]
    -- upvalues: l_Players_0 (copy), v8 (copy), v5 (copy)
    local l_Children_0 = workspace.Players.Survivors:GetChildren();
    local l_ipairs_0 = ipairs;
    local v24 = l_Children_0 or {};
    for _, v26 in l_ipairs_0(v24) do
        if v26.Name == "Dusekkar" then
            local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v26);
            local v28 = l_l_Players_0_PlayerFromCharacter_0 and v8.CurrentActors[l_l_Players_0_PlayerFromCharacter_0];
            if v28 and v28.Config then
                return v28.Config;
            end;
        end;
    end;
    return v5;
end;
v9.new = function(...) --[[ Line: 69 ]] --[[ Name: new ]]
    -- upvalues: v4 (copy), v9 (copy)
    return (setmetatable(v4.new(...), v9));
end;
v9.Init = function(v30) --[[ Line: 75 ]] --[[ Name: Init ]]
    -- upvalues: v29 (copy), v5 (copy), l_ReplicatedStorage_0 (copy), v6 (copy), v17 (copy), v21 (copy), v7 (copy)
    task.delay(math.random(2, 5), function() --[[ Line: 76 ]]
        -- upvalues: v30 (copy), v29 (ref), v5 (ref), l_ReplicatedStorage_0 (ref), v6 (ref), v17 (ref), v21 (ref), v7 (ref)
        if not v30 or not v30.Running then
            return;
        else
            v30.FakeStatuses = {};
            local l_Rig_0 = v30.Survivor.Rig;
            local v32 = v29() or v5;
            local v33 = CFrame.new(v30:GetRandomSpawnInCone(v30.Survivor.Rig.PrimaryPart.Position, NumberRange.new(150, 210), 90, 7, 0.9));
            local v34 = l_ReplicatedStorage_0.Assets.Instances.Nothingburger:Clone();
            v34.Size = Vector3.new(2, 2, 2, 0);
            v34.Transparency = 1;
            v34.Position = v33.Position;
            v34.Name = "TheEvilNoliOOOOO";
            v34.Parent = workspace.Map.Ingame;
            local v35 = script.ScaryMonster:Clone();
            v35.Parent = v34;
            if not v6:GetSettingValue("EpilepsyMode", game.Players.LocalPlayer) or not v30.Killer.Config.isScreamerSensitive then
                v35.Noli:SetAttribute("Spritesheet", v30.Killer.Config.ScreamerSpritesheet or "NoliLaugh");
                v35.Noli:AddTag("Spritesheet");
            elseif v6:GetSettingValue("EpilepsyMode", game.Players.LocalPlayer) and v30.Killer.Config.isScreamerSensitive then
                v35.Noli.Image = v30.Killer.Config.SensitiveScreamerImage or "rbxassetid://89949595020859";
            end;
            local v36 = v17(v32, l_Rig_0.PrimaryPart, "Start");
            local v37 = v17(v32, v34, "StaffBeam");
            for _, v39 in pairs(v37:GetChildren()) do
                v39.Attachment1 = l_Rig_0.PrimaryPart and l_Rig_0.PrimaryPart:FindFirstChildOfClass("Attachment");
            end;
            local v40 = v17(v32, v34, "StaffMagic");
            v21(v40);
            local v41 = v32.VFXTemplate.Hold:Clone();
            v41.Parent = l_Rig_0.PrimaryPart;
            v21(v41);
            v7:Play(v32.Sounds.SpawnProtectionActivate, {
                Parent = l_Rig_0.PrimaryPart
            });
            local v42 = v7:Play(v32.Sounds.SpawnProtectionLoop, {
                Parent = l_Rig_0.PrimaryPart
            });
            v30.Garbage = {
                v36, 
                v37, 
                v40, 
                v41; 
                Face = v34, 
                Loop = v42
            };
            v30.DusekConfig = v32;
            local l_v30_FakeStatus_0 = v30:CreateFakeStatus("Resistance", 5, 10);
            local v44 = false;
            v30.Ended = false;
            while v30 and v30.Running and l_v30_FakeStatus_0 and l_v30_FakeStatus_0.Parent and v34 and v34.Parent do
                local _, v46 = workspace.CurrentCamera:WorldToViewportPoint(v34.Position);
                if v46 then
                    v44 = true;
                    break;
                else
                    task.wait();
                end;
            end;
            v30:ISeeYou(v44);
            return;
        end;
    end);
end;
v9.ISeeYou = function(v47, v48) --[[ Line: 144 ]] --[[ Name: ISeeYou ]]
    -- upvalues: l_TweenService_0 (copy), v7 (copy), v17 (copy)
    if v47.Ended then
        return;
    else
        v47.Ended = true;
        if v47.FakeStatuses and v47.FakeStatuses.Resistance then
            v47.FakeStatuses.Resistance:Destroy();
        end;
        local v49 = v47.Garbage or {};
        local l_Survivor_0 = v47.Survivor;
        local l_DusekConfig_0 = v47.DusekConfig;
        local l_Face_0 = v49.Face;
        local l_Loop_0 = v49.Loop;
        for _, v55 in pairs(v49) do
            game.Debris:AddItem(v55, v48 and 1.35 or 0.1);
        end;
        task.spawn(function() --[[ Line: 163 ]]
            -- upvalues: v48 (copy), l_Face_0 (copy), l_TweenService_0 (ref), l_Loop_0 (copy), v7 (ref), l_DusekConfig_0 (copy), l_Survivor_0 (copy), v17 (ref)
            if v48 and l_Face_0 then
                local v56 = tick();
                local l_Position_0 = l_Face_0.Position;
                local l_CurrentCamera_0 = workspace.CurrentCamera;
                while tick() - v56 <= 1.35 and l_Face_0 do
                    local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(math.clamp((tick() - v56) / 1.35, 0, 1), Enum.EasingStyle.Quart, Enum.EasingDirection.In);
                    local l_Position_1 = l_CurrentCamera_0.CFrame.Position;
                    l_Face_0.ScaryMonster.Noli:SetAttribute("TimeScale", 1 + l_l_TweenService_0_Value_0 * 1.5);
                    l_Face_0.Position = l_Position_0 + (l_Position_1 - l_Position_0) * l_l_TweenService_0_Value_0;
                    task.wait();
                end;
                local v61 = Instance.new("BlurEffect", game.Lighting);
                v61.Size = 35;
                l_TweenService_0:Create(v61, TweenInfo.new(4), {
                    Size = 0
                }):Play();
                game.Debris:AddItem(v61, 4);
            end;
            if l_Loop_0 then
                l_TweenService_0:Create(l_Loop_0, TweenInfo.new(0.3), {
                    PlaybackSpeed = 0
                }):Play();
                v7:Play(l_DusekConfig_0.Sounds.SpawnProtectionShieldBreak, {
                    Parent = l_Survivor_0.Rig.PrimaryPart
                });
                v17(l_DusekConfig_0, l_Survivor_0.Rig.PrimaryPart, "Shatter", 10);
            end;
        end);
        return;
    end;
end;
v9.Destroy = function(v62) --[[ Line: 195 ]] --[[ Name: Destroy ]]
    v62:ISeeYou(false);
    v62:Clean();
end;
return v9;