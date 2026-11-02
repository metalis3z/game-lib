-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Data = {
        Duration = 10, 
        MaxLevel = 10, 
        Stackable = false, 
        Description = "Increases the amount of damage you deal to others.\nEvery level of this status makes you deal 20% more damage."
    }, 
    Applied = function(v0) --[[ Line: 11 ]] --[[ Name: Applied ]]
        if game["Run Service"]:IsServer() and v0.Character then
            local v1 = tonumber(v0.Level * 20);
            if v1 then
                v0.Character:SetAttribute("StrengthBuff", v1);
            end;
        end;
    end, 
    Removed = function(v2) --[[ Line: 20 ]] --[[ Name: Removed ]]
        if game["Run Service"]:IsServer() and v2.Character then
            v2.Character:SetAttribute("StrengthBuff", nil);
        end;
    end
};