-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local l_RunService_0 = game:GetService("RunService");
local v6 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
v0.WalkspeedStart = function(v7) --[[ Line: 11 ]] --[[ Name: WalkspeedStart ]]
    local l_Rig_0 = v7.Rig;
    if not l_Rig_0 then
        return;
    else
        l_Rig_0.firebrand.Transparency = 0;
        l_Rig_0.firebrand.Trail.Enabled = true;
        task.delay(3, function() --[[ Line: 18 ]]
            -- upvalues: l_Rig_0 (copy)
            l_Rig_0.firebrand.Trail.Enabled = false;
            l_Rig_0.firebrand.Transparency = 1;
        end);
        return;
    end;
end;
v0.MinionSummon = function(v9) --[[ Line: 24 ]] --[[ Name: MinionSummon ]]
    local l_Rig_1 = v9.Rig;
    if not l_Rig_1 then
        return;
    else
        l_Rig_1.flipphone.Base.Transparency = 0;
        l_Rig_1.flipphone.Flips.Transparency = 0;
        task.delay(2.25, function() --[[ Line: 31 ]]
            -- upvalues: l_Rig_1 (copy)
            l_Rig_1.flipphone.Base.Transparency = 1;
            l_Rig_1.flipphone.Flips.Transparency = 1;
        end);
        return;
    end;
end;
v0.OnIntroduction = function(_, v12, v13, v14) --[[ Line: 37 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v2 (copy)
    local function v15() --[[ Line: 38 ]] --[[ Name: playAnimations ]]
        -- upvalues: v2 (ref), v12 (copy), v14 (copy)
        v2:PlayDummyCutsceneAnimations(v12, v14, "Introduction");
    end;
    v13.firebrand.Transparency = 0;
    local function v17() --[[ Line: 44 ]] --[[ Name: playFOV ]]
        -- upvalues: v2 (ref), v14 (copy), v13 (copy)
        local l_v2_FOVMultiplier_0 = v2:CreateFOVMultiplier(game.Players.LocalPlayer, 0.35714285714285715, "JohnDoeIntroScene");
        game.Debris:AddItem(l_v2_FOVMultiplier_0, v14 + 0.3);
        task.delay(v14, function() --[[ Line: 48 ]]
            -- upvalues: l_v2_FOVMultiplier_0 (copy), v13 (ref)
            game.TweenService:Create(l_v2_FOVMultiplier_0, TweenInfo.new(0.25), {
                Value = 1
            }):Play();
            v13.firebrand.Transparency = 1;
        end);
    end;
    task.spawn(v15);
    task.spawn(v17);
end;
v0.OnVictory = function(_, v19, v20, _, v22) --[[ Line: 58 ]] --[[ Name: OnVictory ]]
    -- upvalues: v6 (copy), l_RunService_0 (copy)
    if v19 == "Start" then
        v6:SetCustomLighting(v20.Config.OutroLighting);
        local _ = tick();
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        local v24 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 67 ]]
            workspace.CurrentCamera.FieldOfView = 25;
        end);
        task.delay(v22, function() --[[ Line: 71 ]]
            -- upvalues: v24 (copy)
            v24:Disconnect();
        end);
        task.spawn(function() --[[ Line: 76 ]]
            -- upvalues: v20 (copy), v22 (copy), l_RunService_0 (ref)
            local v25 = v20.Config.IntroSky:Clone();
            v25.Parent = game.Lighting;
            game.Debris:AddItem(v25, v22 - 1.5);
            local v26 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
            if v26 then
                local v27 = nil;
                do
                    local l_v27_0 = v27;
                    l_v27_0 = l_RunService_0.RenderStepped:Connect(function(v29) --[[ Line: 84 ]]
                        -- upvalues: v26 (copy), l_v27_0 (ref)
                        if not v26 or not v26.Parent or not v26:FindFirstChild("People") then
                            l_v27_0:Disconnect();
                            return;
                        else
                            for v30, v31 in pairs(v26.People:GetChildren()) do
                                local l_PrimaryPart_0 = v31.PrimaryPart;
                                l_PrimaryPart_0.CFrame = l_PrimaryPart_0.CFrame * CFrame.Angles(0, v29 * (v30 % 2 == 0 and 2.25 or -2.25), 0);
                            end;
                            task.wait();
                            return;
                        end;
                    end);
                    task.delay(v22, l_v27_0.Disconnect, l_v27_0);
                end;
            end;
        end);
        return;
    else
        if v19 == "End" then
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", false);
            game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
            v6:SetAsCurrentLighting();
        end;
        return;
    end;
end;
v0.OnExecution = function(_, _, v35) --[[ Line: 106 ]] --[[ Name: OnExecution ]]
    task.delay(2.1, function() --[[ Line: 113 ]]
        -- upvalues: v35 (copy)
        task.spawn(function() --[[ Line: 115 ]]
            -- upvalues: v35 (ref)
            for _ = 1, math.random(3, 6) do
                local v37 = script.Blood:Clone();
                v37.CFrame = v35.PrimaryPart.CFrame * CFrame.new(math.random(-3, 3), math.random(-3, 3), math.random(-3, 3));
                v37.Parent = workspace;
                game.Debris:AddItem(v37, 10);
                task.wait(math.random(0.25, 0.75));
            end;
        end);
        local l_Humanoid_0 = v35:FindFirstChild("Humanoid");
        require(game.ReplicatedStorage.Modules.Ragdolls).AddProfile(v35, {
            Velocity = Vector3.new(0, 50, 0, 0), 
            KillEffects = {
                HeadSquash = true
            }
        });
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;