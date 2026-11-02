-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = nil, 
    LayoutOrder = 100, 
    Executable = false, 
    DisplayedAttribute = "MaxKillers", 
    Parameters = {
        [1] = {
            Title = "Max Killer Cap", 
            Type = "Number", 
            DefaultValue = 1, 
            Metadata = {
                MinValue = 1, 
                MaxValue = 10, 
                Step = 1
            }
        }
    }, 
    Executed = function(_, _, v2) --[[ Line: 18 ]] --[[ Name: Executed ]]
        if typeof(v2) ~= "number" then
            return;
        else
            workspace:SetAttribute("MaxKillers", v2);
            return;
        end;
    end
};