-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 90,
	Title = "Disable Timer",
	DisplayedAttribute = "NoTimer",
	Executable = true,
    Executed = function(_, _) --[[ Line: 9 ]] --[[ Name: Executed ]]
        local l_workspace_Attribute_0 = workspace:GetAttribute("NoTimer");
        workspace:SetAttribute("NoTimer", not l_workspace_Attribute_0);
	end,
};