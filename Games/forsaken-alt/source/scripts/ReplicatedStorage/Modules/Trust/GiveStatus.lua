-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Apply Status To Player", 
    LayoutOrder = 51, 
    Executable = true, 
    Parameters = {
        [1] = {
            Title = "Inflicted Player", 
            Type = "String", 
            DefaultValue = "..."
        }, 
        [2] = {
            Title = "Status Name", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                Options = function() --[[ Line: 18 ]] --[[ Name: Options ]]
                    local v0 = {};
                    local function v1(v2) --[[ Line: 21 ]] --[[ Name: recursive ]]
                        -- upvalues: v1 (copy), v0 (copy)
                        if v2:IsA("Folder") then
                            for _, v4 in pairs(v2:GetChildren()) do
                                v1(v4);
                            end;
                            return;
                        else
                            table.insert(v0, v2.Name);
                            return;
                        end;
                    end;
                    v1(game.ReplicatedStorage.Modules.StatusEffects);
                    return table.concat(v0, "|");
                end
            }
        }, 
        [3] = {
            Title = "Status Level", 
            Type = "Number", 
            DefaultValue = 1, 
            Metadata = {
                MinValue = 1, 
                MaxValue = 10, 
                Step = 1
            }
        }, 
        [4] = {
            Title = "Status Duration", 
            Type = "Number", 
            DefaultValue = 5, 
            Metadata = {
                MinValue = 5, 
                MaxValue = 90, 
                Step = 5
            }
        }
    }, 
    Executed = function(_, _, v7, v8, v9, v10) --[[ Line: 50 ]] --[[ Name: Executed ]]
        if typeof(v7) ~= "string" then
            return;
        elseif typeof(v8) ~= "string" then
            return;
        elseif typeof(v9) ~= "number" then
            return;
        elseif typeof(v10) ~= "number" then
            return;
        else
            local v11 = {
                v7
            };
            if v7 == "All" then
                for _, v13 in pairs(game.Players:GetPlayers()) do
                    table.insert(v11, v13.Name);
                end;
            end;
            for _, v15 in pairs(v11) do
                local l_FirstChild_0 = game.Players:FindFirstChild(v15);
                if l_FirstChild_0 then
                    require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(l_FirstChild_0, v8, {
                        Level = v9, 
                        Duration = v10
                    });
                end;
            end;
            return;
        end;
    end
};