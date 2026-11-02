-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Force Next Killer", 
    LayoutOrder = 82, 
    Executable = true, 
    ResetOnExecution = true, 
    DisplayedAttribute = "ForcedKiller", 
    DisplayedAttributeDefault = "Random", 
    Parameters = {
        [1] = {
            Title = "Chosen Player", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                AllPlayersOptionDisabled = true
            }
        }
    }, 
    Executed = function(_, _, v2) --[[ Line: 20 ]] --[[ Name: Executed ]]
        if v2 and v2 ~= "..." then
            workspace:SetAttribute("ForcedKiller", v2);
            return;
        else
            workspace:SetAttribute("ForcedKiller", nil);
            return;
        end;
    end
};