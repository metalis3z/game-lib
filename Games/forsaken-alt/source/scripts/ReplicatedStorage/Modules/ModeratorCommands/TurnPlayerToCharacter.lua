-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Make Player Into Survivor/Killer", 
    LayoutOrder = 50, 
    Executable = true, 
    Parameters = {
        [1] = {
            Title = "Chosen Player", 
            Type = "String", 
            DefaultValue = "..."
        }, 
        [2] = {
            Title = "Character Type", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                Options = "Survivor|Killer"
            }
        }
    }, 
    Executed = function(_, _, v2, v3) --[[ Line: 23 ]] --[[ Name: Executed ]]
        if typeof(v2) ~= "string" then
            return;
        elseif v3 ~= "Killer" and v3 ~= "Survivor" then
            return;
        else
            local v4 = {
                v2
            };
            if v2 == "All" then
                for _, v6 in pairs(game.Players:GetPlayers()) do
                    table.insert(v4, v6.Name);
                end;
            end;
            for _, v8 in pairs(v4) do
                local l_FirstChild_0 = game.Players:FindFirstChild(v8);
                if l_FirstChild_0 then
                    local v10 = require(game.ReplicatedStorage.Modules.Actors);
                    v10:CleanupActorFromPlayer(l_FirstChild_0);
                    v10:CreateActor(l_FirstChild_0, v3);
                end;
            end;
            return;
        end;
    end
};