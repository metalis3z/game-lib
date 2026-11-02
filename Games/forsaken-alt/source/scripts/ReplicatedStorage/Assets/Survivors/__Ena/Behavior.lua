-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.AchievementUtil);

v0.Abilities = {
   
};

v0.Created = function(_, v59) --[[ Line: 435 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        return;
    else
        if game["Run Service"]:IsClient() then

        end;
        return;
    end;
end;

return v0;