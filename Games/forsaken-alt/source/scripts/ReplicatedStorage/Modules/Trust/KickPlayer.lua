-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Kick Player", 
    LayoutOrder = -2, 
    Executable = true, 
    ResetOnExecution = true, 
    Parameters = {
        [1] = {
            Title = "Chosen Player", 
            Type = "String", 
            DefaultValue = "..."
        }
    }, 
    Executed = function(_, v1, v2) --[[ Line: 17 ]] --[[ Name: Executed ]]
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
                if l_FirstChild_0 then
                    local v9 = workspace:GetAttribute("ServerOwnerID") == l_FirstChild_0.UserId;
                    local v10 = false;
                    pcall(function() --[[ Line: 35 ]]
                        -- upvalues: v10 (ref), l_FirstChild_0 (copy)
                        v10 = l_FirstChild_0:GetRankInGroup(33548380) >= 100;
                    end);
                    if v9 or v10 then
                        --[[ close >= 11 ]]
                    else
                        l_FirstChild_0:Kick((("You've been kicked from the server by %*."):format((tostring(v1)))));
                        --[[ close >= 11 ]]
                    end;
                end;
            end;
            return;
        end;
    end
};