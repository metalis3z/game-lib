-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:19 2025 ]]
local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.OnExecution = function(_, v8, v9) --[[ Line: 10 ]] --[[ Name: OnExecution ]]
    local v10 = require(game.ReplicatedStorage.Modules.Ragdolls);
    local v11 = v9.Name == "Guest1337";
    local v12 = v11 and -v8.Rig.PrimaryPart.CFrame.RightVector;
    local v13 = v11 and 4.6 or 1.125;
    delay(v13, function() --[[ Line: 20 ]]
        -- upvalues: v10 (copy), v9 (copy), v12 (copy), v11 (copy)
        v10.AddProfile(v9, {
            Velocity = v12, 
            KillEffects = if v11 then {
                Decapitate = true
            } else nil
        });
        local l_Humanoid_0 = v9:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;