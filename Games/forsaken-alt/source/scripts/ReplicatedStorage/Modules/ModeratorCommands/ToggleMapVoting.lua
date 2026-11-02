-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Enable Map Voting", 
    LayoutOrder = 91, 
    Executable = true, 
    DisplayedAttribute = "MapVotingEnabled", 
    RequiredRank = "Moderator", 
    Executed = function(_, _) --[[ Line: 10 ]] --[[ Name: Executed ]]
        local l_workspace_Attribute_0 = workspace:GetAttribute("MapVotingEnabled");
        workspace:SetAttribute("MapVotingEnabled", not l_workspace_Attribute_0);
    end
};