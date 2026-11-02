-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:08 2025 ]]
local v0 = {};
local _ = game:GetService("ReplicatedStorage");
local v2 = require(game.ReplicatedStorage.Modules.Util);
v0.OnIntroduction = function(_, v4, v5, v6) --[[ Line: 5 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v2 (copy)
    v2:CreateFOVMultiplier(game.Players.LocalPlayer, 0.3, "Screamer", v6);
    local _ = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
    v5.SCREAMER["Right Arm.003"].Transparency = 1;
    v5.SCREAMER["Right Arm.004"].Transparency = 1;
    v5.SCREAMER["RightNorm Arm.001"].Transparency = 0;
    v5.SCREAMER.NH1.Transparency = 0;
    v5.SCREAMER.NH2.Transparency = 0;
    v5.SCREAMER.Head.Transparency = 1;
    task.delay(3.81, function() --[[ Line: 16 ]]
        -- upvalues: v5 (copy), v4 (copy)
        v5.SCREAMER["Right Arm.003"].Transparency = 0;
        v5.SCREAMER["Right Arm.004"].Transparency = 0;
        v5.SCREAMER["RightNorm Arm.001"].Transparency = 1;
        v5.SCREAMER.NH1.Transparency = 1;
        v5.SCREAMER.NH2.Transparency = 1;
        v5.SCREAMER.Head.Transparency = 0;
        local v8 = v4.Config.JDFrame:Clone();
        v8.Parent = game.Players.LocalPlayer.PlayerGui;
        game.Debris:AddItem(v8, 2);
    end);
end;
v0.OnExecution = function(_, v10, v11) --[[ Line: 30 ]] --[[ Name: OnExecution ]]
    local v12 = require(game.ReplicatedStorage.Modules.Ragdolls);
    local l_Humanoid_0 = v11:FindFirstChild("Humanoid");
    local v14 = v10.Rig.PrimaryPart.CFrame.LookVector.Unit * 20;
    task.delay(2.43, function() --[[ Line: 37 ]]
        -- upvalues: l_Humanoid_0 (copy), v12 (copy), v11 (copy), v14 (copy)
        if l_Humanoid_0 then
            v12.AddProfile(v11, {
                Velocity = v14
            });
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;