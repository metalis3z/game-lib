-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 91,
	AllowedInVIP = true,
	RequiredRank = "Moderator",
	DisplayedAttribute = "MapVotingEnabled",
	Title = "Enable Map Voting",
	Executable = true,
    Executed = function(_, _) --[[ Line: 9 ]] --[[ Name: Executed ]]
        local l_workspace_Attribute_0 = workspace:GetAttribute("MapVotingEnabled");
		workspace:SetAttribute("MapVotingEnabled", not l_workspace_Attribute_0);
	end,
};