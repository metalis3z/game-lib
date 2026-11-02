-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 82,
	DisplayedAttributeDefault = "Random",
	Executable = true,
	ResetOnExecution = true,
	Parameters = {
		[1] = {
			Title = "Chosen Player",
			Type = "String",
			DefaultValue = "...",
			Metadata = {
				AllPlayersOptionDisabled = true,
			},
		},
	},
	DisplayedAttribute = "ForcedKiller",
	Title = "Force Next Killer",
    Executed = function(_, _, v2) --[[ Line: 20 ]] --[[ Name: Executed ]]
        if v2 and v2 ~= "..." then
            workspace:SetAttribute("ForcedKiller", v2);
            return;
        else
            workspace:SetAttribute("ForcedKiller", nil);
            return;
        end;
	end,
};