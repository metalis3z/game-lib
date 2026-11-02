-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 100,
	Executable = false,
	Name = "MaxKillerCap",
	DisplayedAttribute = "MaxKillers",
	RequiredRank = "HeadModerator",
	AllowedInVIP = true,
	Parameters = {
		[1] = {
			Title = "Max Killer Cap",
			Type = "Number",
			DefaultValue = 1,
			Metadata = {
				MinValue = 1,
				Step = 1,
				MaxValue = 10,
			},
		},
	},
    Executed = function(_, _, v2) --[[ Line: 18 ]] --[[ Name: Executed ]]
        if typeof(v2) ~= "number" then
            return;
        else
            workspace:SetAttribute("MaxKillers", v2);
            return;
        end;
	end,
};