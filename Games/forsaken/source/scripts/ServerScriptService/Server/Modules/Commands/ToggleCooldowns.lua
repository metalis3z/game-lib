-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 96,
	AllowedInVIP = true,
	RequiredRank = "HeadModerator",
	DisplayedAttribute = "CooldownsDisabled",
	Title = "Disable Ability Cooldowns",
	Executable = true,
    Executed = function(_, _) --[[ Line: 9 ]] --[[ Name: Executed ]]
        local l_workspace_Attribute_0 = workspace:GetAttribute("CooldownsDisabled");
        workspace:SetAttribute("CooldownsDisabled", not l_workspace_Attribute_0);
	end,
};