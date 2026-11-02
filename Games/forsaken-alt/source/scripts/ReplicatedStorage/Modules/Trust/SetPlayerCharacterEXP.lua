-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Set Level Of A Player's Character", 
    LayoutOrder = 22, 
    Executable = true, 
    RequiredRank = "Developer", 
    Parameters = {
        [1] = {
            Title = "Chosen Player", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                AllPlayersOptionDisabled = true
            }
        }, 
        [2] = {
            Title = "Chosen Character", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                Options = function() --[[ Line: 21 ]] --[[ Name: Options ]]
                    local v0 = {};
                    for _, v2 in pairs({
                        game.ReplicatedStorage.Assets.Killers, 
                        game.ReplicatedStorage.Assets.Survivors
                    }) do
                        for _, v4 in pairs(v2:GetChildren()) do
                            table.insert(v0, (("%*/%*"):format(v2.Name, v4.Name)));
                        end;
                    end;
                    return table.concat(v0, "|");
                end
            }
        }, 
        [3] = {
            Title = "Specified Level", 
            Type = "Number", 
            DefaultValue = 1, 
            Metadata = {
                MinValue = 1, 
                MaxValue = 100, 
                Step = 1
            }
        }
    }, 
    Executed = function(_, _, v7, v8, v9) --[[ Line: 41 ]] --[[ Name: Executed ]]
        if typeof(v7) ~= "string" then
            return;
        elseif typeof(v8) ~= "string" then
            return;
        elseif typeof(v9) ~= "number" then
            return;
        elseif v9 <= 0 then
            return;
        else
            local l_FirstChild_0 = game.Players:FindFirstChild(v7);
            if l_FirstChild_0 then
                local v11 = string.split(v8, "/");
                local v12 = v11[1];
                local v13 = v11[2];
                local l_FirstChild_1 = l_FirstChild_0.PlayerData.Purchased:FindFirstChild(v12);
                if l_FirstChild_1 then
                    local l_l_FirstChild_1_FirstChild_0 = l_FirstChild_1:FindFirstChild(v13);
                    if not l_l_FirstChild_1_FirstChild_0 then
                        l_l_FirstChild_1_FirstChild_0 = Instance.new("NumberValue");
                        l_l_FirstChild_1_FirstChild_0.Name = v13;
                        l_l_FirstChild_1_FirstChild_0.Parent = l_FirstChild_1;
                    end;
                    local v16 = 0;
                    for v17 = 1, v9 - 1 do
                        v16 = v16 + math.round(100 + 10 * v17);
                    end;
                    l_l_FirstChild_1_FirstChild_0.Value = v16;
                end;
            end;
            return;
        end;
    end
};