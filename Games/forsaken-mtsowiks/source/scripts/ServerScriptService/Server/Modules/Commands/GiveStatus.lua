-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 51,
	Title = "Apply Status To Player",
	Parameters = {
		[1] = {
			Type = "String",
			DefaultValue = "...",
			Title = "Inflicted Player",
		},
		[2] = {
			Title = "Status Name",
			Type = "String",
			DefaultValue = "...",
			Metadata = {
				Options = "GIVE_STATUS",
			},
		},
		[3] = {
			Title = "Status Level",
			Type = "Number",
			DefaultValue = 1,
			Metadata = {
				MinValue = 1,
				Step = 1,
				MaxValue = 10,
			},
		},
		[4] = {
			Title = "Status Duration",
			Type = "Number",
			DefaultValue = 5,
			Metadata = {
				MinValue = 5,
				Step = 5,
				MaxValue = 90,
			},
		},
	},
	Executable = true,
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
	end,
};