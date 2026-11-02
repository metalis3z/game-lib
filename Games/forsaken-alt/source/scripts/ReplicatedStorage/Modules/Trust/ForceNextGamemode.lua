-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Force Next Gamemode", 
    LayoutOrder = 81, 
    Executable = true, 
    ResetOnExecution = true, 
    DisplayedAttribute = "ForcedGamemode", 
    DisplayedAttributeDefault = "N/A", 
    Parameters = {
        [1] = {
            Title = "Chosen Gamemode", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                Options = function() --[[ Line: 15 ]] --[[ Name: Options ]]
                    local v0 = {};
                    for _, v2 in pairs(game.ReplicatedStorage.Modules.Gamemodes:GetChildren()) do
                        table.insert(v0, v2.Name);
                    end;
                    return table.concat(v0, "|");
                end
            }
        }
    }, 
    Executed = function(_, _, v5) --[[ Line: 29 ]] --[[ Name: Executed ]]
        if v5 and v5 ~= "..." then
            workspace:SetAttribute("ForcedGamemode", v5);
            return;
        else
            workspace:SetAttribute("ForcedGamemode", nil);
            return;
        end;
    end
};