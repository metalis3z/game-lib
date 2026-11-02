-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:39 2025 ]]
local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local l_RunService_0 = game:GetService("RunService");
local v6 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
v0.OnExecution = function(_, v8, v9) --[[ Line: 11 ]] --[[ Name: OnExecution ]]
    local l_Explosion_0 = script.Explosion;
    local l_Rig_0 = v8.Rig;
    l_Rig_0.TennaHead.Smile.Decal.Texture = "rbxassetid://72402539174557";
    task.delay(0.8, function() --[[ Line: 22 ]]
        -- upvalues: v9 (copy), l_Rig_0 (copy), l_Explosion_0 (copy)
        local l_Humanoid_0 = v9:FindFirstChild("Humanoid");
        local l_l_Rig_0_FirstChild_0 = l_Rig_0:FindFirstChild("Left Leg");
        local v14 = l_Explosion_0:Clone();
        v14.Parent = l_l_Rig_0_FirstChild_0;
        require(game.ReplicatedStorage.Modules.Ragdolls).AddProfile(v9, {
            Velocity = Vector3.new(200, 200, 100, 0), 
            KillEffects = {
                HeadSquash = true
            }
        });
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
            v14:Emit(15);
            l_Rig_0.TennaHead.Smile.Decal.Texture = "rbxassetid://101478310078266";
        end;
        task.wait(3);
        v14:Destroy();
    end);
end;
v0.WalkspeedStart = function(v15) --[[ Line: 46 ]] --[[ Name: WalkspeedStart ]]
    local l_Rig_1 = v15.Rig;
    if not l_Rig_1 then
        return;
    else
        l_Rig_1.firebrand.Transparency = 0;
        l_Rig_1.firebrand.Trail.Enabled = true;
        l_Rig_1.TennaHead.Smile.Decal.Texture = "rbxassetid://72402539174557";
        task.delay(3, function() --[[ Line: 55 ]]
            -- upvalues: l_Rig_1 (copy)
            l_Rig_1.firebrand.Trail.Enabled = false;
            l_Rig_1.firebrand.Transparency = 1;
            l_Rig_1.TennaHead.Smile.Decal.Texture = "rbxassetid://101478310078266";
        end);
        return;
    end;
end;
v0.MinionSummon = function(v17) --[[ Line: 62 ]] --[[ Name: MinionSummon ]]
    local l_Rig_2 = v17.Rig;
    if not l_Rig_2 then
        return;
    else
        l_Rig_2.TennaHead.Smile.Decal.Texture = "rbxassetid://78312748935072";
        task.delay(2.25, function() --[[ Line: 69 ]]
            -- upvalues: l_Rig_2 (copy)
            l_Rig_2.TennaHead.Smile.Decal.Texture = "rbxassetid://101478310078266";
        end);
        return;
    end;
end;
v0.OnIntroduction = function(_, v20, _, v22) --[[ Line: 75 ]] --[[ Name: OnIntroduction ]]
    local v23 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    v23:SetCustomLighting(v20.Config.IntroLighting);
    task.delay(v22, function() --[[ Line: 80 ]]
        -- upvalues: v23 (copy)
        v23:SetAsCurrentLighting();
    end);
end;
v0.OnVictory = function(_, v25, v26, _, v28) --[[ Line: 85 ]] --[[ Name: OnVictory ]]
    -- upvalues: v6 (copy), l_RunService_0 (copy)
    if v25 == "Start" then
        v6:SetCustomLighting(v26.Config.OutroLighting);
        local _ = tick();
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        local v30 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 94 ]]
            workspace.CurrentCamera.FieldOfView = 25;
        end);
        task.delay(v28, function() --[[ Line: 98 ]]
            -- upvalues: v30 (copy)
            v30:Disconnect();
        end);
        return;
    else
        if v25 == "End" then
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", false);
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
            v6:SetAsCurrentLighting();
        end;
        return;
    end;
end;
return v0;