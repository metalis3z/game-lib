-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Created = function(_, v6) --[[ Line: 9 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        task.delay(0.75, function() --[[ Line: 11 ]]
            -- upvalues: v6 (copy)
            v6.Rig.Spinny.Enabled = true;
        end);
    end;
end;
return v0;