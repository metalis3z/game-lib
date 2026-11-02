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
    local l_Humanoid_0 = v14:FindFirstChild("Humanoid");
    local v16 = workspace:GetServerTimeNow() + 1.55;
    local v17 = v13.Rig.PrimaryPart.CFrame.LookVector.Unit * 200;
    require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v14, v16, (("%*|%*|%*"):format(v17.X, v17.Y, v17.Z)));
    task.delay(1.57, function() --[[ Line: 33 ]]
        -- upvalues: l_Humanoid_0 (copy), v14 (copy)
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
            local l_ipairs_0 = ipairs;
            local v19 = v14 and v14:GetChildren() or {};
            for _, v21 in l_ipairs_0(v19) do
                if v21:IsA("Accessory") then
                    v21:Destroy();
                end;
            end;
        end;
    end);
end;
return v0;