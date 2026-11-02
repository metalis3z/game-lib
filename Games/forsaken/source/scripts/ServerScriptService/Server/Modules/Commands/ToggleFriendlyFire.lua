-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 95,
	AllowedInVIP = true,
	RequiredRank = "HeadModerator",
	DisplayedAttribute = "FriendlyFire",
	Title = "Enable Friendly Fire",
	Executable = true,
    Executed = function(_, _) --[[ Line: 9 ]] --[[ Name: Executed ]]
        local l_workspace_Attribute_0 = workspace:GetAttribute("FriendlyFire");
        workspace:SetAttribute("FriendlyFire", not l_workspace_Attribute_0);
	end,
};