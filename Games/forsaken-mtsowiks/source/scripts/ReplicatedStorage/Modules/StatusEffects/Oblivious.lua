-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Data = {
        Duration = 10, 
        MaxLevel = 1, 
        Stackable = false, 
        Description = "Makes you unable to hear the terror radius themes of killers."
    }, 
    Applied = function(_) --[[ Line: 11 ]] --[[ Name: Applied ]]
        if game["Run Service"]:IsClient() then
            local l_Character_0 = game.Players.LocalPlayer.Character;
            if l_Character_0 then
                l_Character_0:SetAttribute("MuteChaseThemes", true);
            end;
        end;
    end, 
    Removed = function(_) --[[ Line: 21 ]] --[[ Name: Removed ]]
        if game["Run Service"]:IsClient() then
            local l_Character_1 = game.Players.LocalPlayer.Character;
            if l_Character_1 then
                l_Character_1:SetAttribute("MuteChaseThemes", nil);
            end;
        end;
    end
};