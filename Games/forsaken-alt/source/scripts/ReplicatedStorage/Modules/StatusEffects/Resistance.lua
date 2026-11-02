-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Data = {
        Duration = 10, 
        MaxLevel = 10, 
        Stackable = false, 
        Description = "Makes you less susceptible to damage.\nEvery level of this status makes you receive 20% less damage."
    }, 
    Applied = function(v0) --[[ Line: 11 ]] --[[ Name: Applied ]]
        if game["Run Service"]:IsServer() and v0.Character then
            local v1 = tonumber(v0.Level * 20);
            if v1 then
                require(game.ReplicatedStorage.Modules.Util):CreateResistanceMultiplier(v0.Character, v1, "ResistanceStatus", v0.Data.Duration);
            end;
        end;
    end, 
    Removed = function(v2) --[[ Line: 21 ]] --[[ Name: Removed ]]
        if game["Run Service"]:IsServer() and v2.Character then
            require(game.ReplicatedStorage.Modules.Util):CreateResistanceMultiplier(v2.Character, 1, "ResistanceStatus", 0);
        end;
    end
};