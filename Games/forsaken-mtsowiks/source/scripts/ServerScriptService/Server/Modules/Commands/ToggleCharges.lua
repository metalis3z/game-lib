-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 97,
	AllowedInVIP = true,
	RequiredRank = "HeadModerator",
	DisplayedAttribute = "ChargesDisabled",
	Title = "Disable Ability Charge Requirement",
	Executable = true,
    Executed = function(_, _) --[[ Line: 9 ]] --[[ Name: Executed ]]
        local l_workspace_Attribute_0 = workspace:GetAttribute("ChargesDisabled");
        workspace:SetAttribute("ChargesDisabled", not l_workspace_Attribute_0);
	end,
};