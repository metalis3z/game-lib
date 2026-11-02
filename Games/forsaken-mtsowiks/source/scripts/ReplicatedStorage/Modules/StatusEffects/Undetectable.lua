-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Data = {
        Duration = 5, 
        MaxLevel = 1, 
        Stackable = false, 
        Description = "Makes your aura (and terror radius if you're the killer) unreadable."
    }, 
    Applied = function(v0) --[[ Line: 11 ]] --[[ Name: Applied ]]
        if game["Run Service"]:IsServer() then
            local l_Character_0 = v0.Character;
            if l_Character_0 then
                require(game.ReplicatedStorage.Modules.Util):RemovePlayerAuraFrom(v0.Player);
                l_Character_0:SetAttribute("Undetectable", true);
            end;
        end;
    end, 
    Removed = function(v2) --[[ Line: 22 ]] --[[ Name: Removed ]]
        if game["Run Service"]:IsServer() then
            local l_Character_1 = v2.Character;
            if l_Character_1 then
                l_Character_1:SetAttribute("Undetectable", nil);
            end;
        end;
    end
};