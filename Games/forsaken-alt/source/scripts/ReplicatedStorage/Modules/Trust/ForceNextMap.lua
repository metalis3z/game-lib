-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Force Next Map", 
    LayoutOrder = 80, 
    Executable = true, 
    ResetOnExecution = true, 
    DisplayedAttribute = "ForcedMap", 
    DisplayedAttributeDefault = "N/A", 
    Parameters = {
        [1] = {
            Title = "Chosen Map", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                Options = function() --[[ Line: 15 ]] --[[ Name: Options ]]
                    return workspace:GetAttribute("MapNames") or "ClickThe|DropdownAgain|Please";
                end
            }
        }
    }, 
    Executed = function(_, _, v2) --[[ Line: 23 ]] --[[ Name: Executed ]]
        if v2 and v2 ~= "..." then
            workspace:SetAttribute("ForcedMap", v2);
            return;
        else
            workspace:SetAttribute("ForcedMap", nil);
            return;
        end;
    end
};