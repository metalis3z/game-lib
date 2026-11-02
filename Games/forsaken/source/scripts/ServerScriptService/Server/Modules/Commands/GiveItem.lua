-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 52,
	Title = "Give Item To Player",
	Parameters = {
		[1] = {
			Type = "String",
			DefaultValue = "...",
			Title = "Affected Player",
		},
		[2] = {
			Title = "Item Name",
			Type = "String",
			DefaultValue = "...",
			Metadata = {
				Options = "GIVE_ITEM",
			},
		},
		[3] = {
			Title = "Item Amount",
			Type = "Number",
			DefaultValue = 1,
			Metadata = {
				MinValue = 1,
				Step = 1,
				MaxValue = 10,
			},
		},
	},
	Executable = true,
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
							if not l_Item_0 then return end
							l_Item_0.Item.Parent = workspace.Map.Ingame
							l_Item_0:SetCFrame(l_FirstChild_0.Character.PrimaryPart.CFrame)
                            l_Item_0:GiveTo(l_FirstChild_0)
                        end);
                    end;
                end;
            end;
            return;
        end;
	end,
};