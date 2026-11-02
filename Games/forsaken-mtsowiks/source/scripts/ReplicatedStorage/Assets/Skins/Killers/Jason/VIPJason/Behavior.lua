-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:07:48 2025 ]]
local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.OnExecution = function(_, _, v9) --[[ Line: 12 ]] --[[ Name: OnExecution ]]
    task.delay(3, function() --[[ Line: 16 ]]
        -- upvalues: v9 (copy)
        local l_Humanoid_0 = v9:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;