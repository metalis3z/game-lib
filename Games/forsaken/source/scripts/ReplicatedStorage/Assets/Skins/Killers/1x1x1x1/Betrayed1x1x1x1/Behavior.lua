-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
v0.OnIntroduction = function(_, v7, _, v9) --[[ Line: 10 ]] --[[ Name: OnIntroduction ]]
    local l_FOVMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(game.Players.LocalPlayer, 0.35, "BetrayedIntroScene");
    game.Debris:AddItem(l_FOVMultiplier_0, v9);
    local v11 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
    v11:SetCustomLighting(v7.Config.IntroLighting);
    task.delay(v9, function() --[[ Line: 19 ]]
        -- upvalues: v11 (copy)
        v11:SetAsCurrentLighting();
    end);
end;
v0.OnExecution = function(_, v13, v14) --[[ Line: 24 ]] --[[ Name: OnExecution ]]
    local v15 = require(game.ReplicatedStorage.Modules.Ragdolls);
    local l_Humanoid_0 = v14:FindFirstChild("Humanoid");
    local v17 = v13.Rig.PrimaryPart.CFrame.LookVector.Unit * 200;
    task.delay(1.57, function() --[[ Line: 31 ]]
        -- upvalues: l_Humanoid_0 (copy), v15 (copy), v14 (copy), v17 (copy)
        if l_Humanoid_0 then
            v15.AddProfile(v14, {
                Velocity = v17
            });
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;