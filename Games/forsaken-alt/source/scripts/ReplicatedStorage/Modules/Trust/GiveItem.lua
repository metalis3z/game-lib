-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Title = "Give Item To Player", 
    LayoutOrder = 52, 
    Executable = true, 
    Parameters = {
        [1] = {
            Title = "Affected Player", 
            Type = "String", 
            DefaultValue = "..."
        }, 
        [2] = {
            Title = "Item Name", 
            Type = "String", 
            DefaultValue = "...", 
            Metadata = {
                Options = function() --[[ Line: 18 ]] --[[ Name: Options ]]
                    local v0 = {};
                    for _, v2 in pairs(game.ReplicatedStorage.Assets.Items:GetChildren()) do
                        table.insert(v0, v2.Name);
                    end;
                    return table.concat(v0, "|");
                end
            }
        }, 
        [3] = {
            Title = "Item Amount", 
            Type = "Number", 
            DefaultValue = 1, 
            Metadata = {
                MinValue = 1, 
                MaxValue = 10, 
                Step = 1
            }
        }
    }, 
    Executed = function(_, _, v5, v6, v7) --[[ Line: 36 ]] --[[ Name: Executed ]]
        if typeof(v5) ~= "string" then
            return;
        elseif typeof(v6) ~= "string" then
            return;
        elseif typeof(v7) ~= "number" then
            return;
        else
            local v8 = {
                v5
            };
            if v5 == "All" then
                for _, v10 in pairs(game.Players:GetPlayers()) do
                    table.insert(v8, v10.Name);
                end;
            end;
            for _, v12 in pairs(v8) do
                local l_FirstChild_0 = game.Players:FindFirstChild(v12);
                if l_FirstChild_0 then
                    for _ = 1, v7 do
                        task.spawn(function() --[[ Line: 55 ]]
                            -- upvalues: v6 (copy), l_FirstChild_0 (copy)
                            local l_Item_0 = require(game.ReplicatedStorage.Modules.Items):CreateItem(v6);
                            if l_Item_0 then
                                l_Item_0.Item.Parent = l_FirstChild_0.Backpack;
                            end;
                        end);
                    end;
                end;
            end;
            return;
        end;
    end
};