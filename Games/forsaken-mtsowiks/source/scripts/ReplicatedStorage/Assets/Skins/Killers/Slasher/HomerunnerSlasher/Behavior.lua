-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = game:GetService("RunService");
local _ = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
v0.GashingWoundStart = function(_, v8) --[[ Line: 10 ]] --[[ Name: GashingWoundStart ]]
    local l_Rig_0 = v8.Rig;
    if not l_Rig_0 then
        return;
    else
        task.delay(0.68, function() --[[ Line: 14 ]]
            -- upvalues: l_Rig_0 (copy)
            l_Rig_0.Alpha.Transparency = 0;
            l_Rig_0.Epsilon.Transparency = 0;
            l_Rig_0.Omega.Transparency = 0;
        end);
        task.delay(4.55, function() --[[ Line: 20 ]]
            -- upvalues: l_Rig_0 (copy)
            l_Rig_0.Alpha.Transparency = 1;
            l_Rig_0.Epsilon.Transparency = 1;
            l_Rig_0.Omega.Transparency = 1;
        end);
        return;
    end;
end;
return v0;