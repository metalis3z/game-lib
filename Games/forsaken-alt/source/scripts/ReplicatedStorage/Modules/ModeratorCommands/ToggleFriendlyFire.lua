-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Enable Friendly Fire", 
    LayoutOrder = 95, 
    Executable = true, 
    DisplayedAttribute = "FriendlyFire", 
    Executed = function(_, _) --[[ Line: 9 ]] --[[ Name: Executed ]]
        local l_workspace_Attribute_0 = workspace:GetAttribute("FriendlyFire");
        workspace:SetAttribute("FriendlyFire", not l_workspace_Attribute_0);
    end
};