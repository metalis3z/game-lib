-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 80,
	DisplayedAttributeDefault = "N/A",
	Executable = true,
	ResetOnExecution = true,
	Parameters = {
		[1] = {
			Title = "Chosen Map",
			Type = "String",
			DefaultValue = "...",
			Metadata = {
				Options = "FORCE_NEXT_MAP",
			},
		},
	},
	DisplayedAttribute = "ForcedMap",
	Title = "Force Next Map",
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