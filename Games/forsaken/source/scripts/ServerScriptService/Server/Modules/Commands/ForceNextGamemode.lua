-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 81,
	DisplayedAttributeDefault = "N/A",
	Executable = true,
	ResetOnExecution = true,
	Parameters = {
		[1] = {
			Title = "Chosen Gamemode",
			Type = "String",
			DefaultValue = "...",
			Metadata = {
				Options = "FORCE_NEXT_GAMEMODE",
			},
		},
	},
	DisplayedAttribute = "ForcedGamemode",
	Title = "Force Next Gamemode",
    Executed = function(_, _, v5) --[[ Line: 29 ]] --[[ Name: Executed ]]
        if v5 and v5 ~= "..." then
            workspace:SetAttribute("ForcedGamemode", v5);
            return;
        else
            workspace:SetAttribute("ForcedGamemode", nil);
            return;
        end;
	end,
};