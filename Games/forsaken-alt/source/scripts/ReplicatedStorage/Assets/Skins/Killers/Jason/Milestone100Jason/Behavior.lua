-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.OnExecution = function(_, _, v9) --[[ Line: 12 ]] --[[ Name: OnExecution ]]
    -- upvalues: v5 (copy)
    local v10 = workspace:GetServerTimeNow() + 3;
    v5:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v9, v10, "0|-25|0", v9.PrimaryPart and v9.PrimaryPart.CFrame * CFrame.new(-4, -2.25, -1.5) * CFrame.Angles(-2.0943951023931953, 3.141592653589793, 0));
    task.delay(3, function() --[[ Line: 20 ]]
        -- upvalues: v9 (copy)
        local l_Humanoid_0 = v9:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
return v0;