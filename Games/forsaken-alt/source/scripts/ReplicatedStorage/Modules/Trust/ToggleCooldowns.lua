-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Disable Ability Cooldowns", 
    LayoutOrder = 96, 
    Executable = true, 
    DisplayedAttribute = "CooldownsDisabled", 
    Executed = function(_, _) --[[ Line: 9 ]] --[[ Name: Executed ]]
        local l_workspace_Attribute_0 = workspace:GetAttribute("CooldownsDisabled");
        workspace:SetAttribute("CooldownsDisabled", not l_workspace_Attribute_0);
    end
};