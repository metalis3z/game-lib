-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Kill Player", 
    LayoutOrder = -1, 
    Executable = true, 
    Parameters = {
        [1] = {
            Title = "Chosen Player", 
            Type = "String", 
            DefaultValue = "..."
        }
    }, 
    Executed = function(_, _, v2) --[[ Line: 17 ]] --[[ Name: Executed ]]
        if typeof(v2) ~= "string" then
            return;
        else
            local v3 = {
                v2
            };
            if v2 == "All" then
                for _, v5 in pairs(game.Players:GetPlayers()) do
                    table.insert(v3, v5.Name);
                end;
            end;
            for _, v7 in pairs(v3) do
                local l_FirstChild_0 = game.Players:FindFirstChild(v7);
                local v9 = l_FirstChild_0 and l_FirstChild_0.Character;
                local v10 = v9 and v9:FindFirstChild("Humanoid");
                if v10 then
                    v10.Health = 0;
                end;
            end;
            return;
        end;
    end
};