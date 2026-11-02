-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local _ = require(game.ReplicatedStorage.Modules.AchievementUtil);
v0.OnExecution = function(_, v8, v9) --[[ Line: 12 ]] --[[ Name: OnExecution ]]
    local v10 = require(game.ReplicatedStorage.Modules.Ragdolls);
    local v11 = v9.Name == "Guest1337";
    local v12 = v11 and -v8.Rig.PrimaryPart.CFrame.RightVector or (v8.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 1, 0, 0)) * 600;
    local v13 = v11 and 4.91 or 1.8333333333333333;
    task.delay(v13, function() --[[ Line: 23 ]]
        -- upvalues: v10 (copy), v9 (copy), v12 (copy)
        v10.SetProfile(v9, {
            Velocity = v12, 
            AnchorDelay = true
        });
        local l_Humanoid_0 = v9:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.Health = 0;
            v9.PrimaryPart.Anchored = false;
        end;
    end);
end;
return v0;