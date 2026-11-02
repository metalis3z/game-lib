-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Disable Ability Charge Requirement", 
    LayoutOrder = 97, 
    Executable = true, 
    DisplayedAttribute = "ChargesDisabled", 
    Executed = function(_, _) --[[ Line: 9 ]] --[[ Name: Executed ]]
        local l_workspace_Attribute_0 = workspace:GetAttribute("ChargesDisabled");
        workspace:SetAttribute("ChargesDisabled", not l_workspace_Attribute_0);
    end
};