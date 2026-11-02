-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Data = {
        Duration = 10, 
        MaxLevel = 1, 
        Stackable = false, 
        Description = "Makes you unable to use any of your abilities."
    }, 
    Applied = function(v0) --[[ Line: 11 ]] --[[ Name: Applied ]]
        if game["Run Service"]:IsClient() then
            require(game.ReplicatedStorage.Modules.Util):ToggleLocksForAbilityIcons("Helpless", true);
            return;
        else
            if game["Run Service"]:IsServer() then
                local l_Character_0 = v0.Character;
                if l_Character_0 then
                    l_Character_0:SetAttribute("AbilitiesDisabled", true);
                end;
            end;
            return;
        end;
    end, 
    Removed = function(v2) --[[ Line: 24 ]] --[[ Name: Removed ]]
        if game["Run Service"]:IsClient() then
            require(game.ReplicatedStorage.Modules.Util):ToggleLocksForAbilityIcons("Helpless", false);
            return;
        else
            if game["Run Service"]:IsServer() then
                local l_Character_1 = v2.Character;
                if l_Character_1 then
                    l_Character_1:SetAttribute("AbilitiesDisabled", nil);
                end;
            end;
            return;
        end;
    end
};