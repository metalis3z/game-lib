-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Set Server Type", 
    LayoutOrder = -6, 
    Executable = true, 
	DisplayedAttribute = "ServerType", 
	RequiredRank = "LeadDeveloper",
	AllowedInVIP = false,
    Parameters = {
        [1] = {
            Title = "Chosen Server Type", 
            Type = "String", 
			DefaultValue = workspace:GetAttribute("ServerType") or "Standard", 
            Metadata = {
                Options = function() --[[ Line: 15 ]] --[[ Name: Options ]]
                    return "Standard|VIP"
                end
            }
        }
    }, 
    Executed = function(_, _, v5) --[[ Line: 29 ]] --[[ Name: Executed ]]
        if v5 then
            workspace:SetAttribute("ServerType", v5);
            return;
        else
            --workspace:SetAttribute("ServerType", nil);
            return;
        end;
    end
};