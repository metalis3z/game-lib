-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = -2,
	Title = "Kick Player",
	ResetOnExecution = true,
	Parameters = {
		[1] = {
			Type = "String",
			DefaultValue = "...",
			Title = "Chosen Player",
		},
	},
	Executable = true,
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
                    l_FirstChild_0:Kick((("You've been kicked from the server by %*."):format((tostring(v1)))));
                end;
            end;
            return;
        end;
	end,
};