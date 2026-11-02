-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:07:50 2025 ]]
local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.OnExecution = function(_, _, v9) --[[ Line: 12 ]] --[[ Name: OnExecution ]]
    local v10 = require(game.ReplicatedStorage.Modules.Ragdolls);
    task.delay(3, function() --[[ Line: 17 ]]
        -- upvalues: v10 (copy), v9 (copy)
        v10.AddProfile(v9, {
            KillEffects = {
                HeadSquash = true
            }, 
            Applied = os.clock() + 2
        });
        local l_Humanoid_0 = v9:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;