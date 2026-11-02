-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	LayoutOrder = 53,
	Title = "Ragdoll Player",
	Parameters = {
		[1] = {
			Type = "String",
			DefaultValue = "...",
			Title = "Affected Player",
		},
		[2] = {
			Title = "Ragdoll State",
			Type = "String",
			DefaultValue = "...",
			Metadata = {
				Options = "Enabled|Disabled",
			},
		},
	},
	Executable = true,
    Executed = function(_, _, v2, v3) --[[ Line: 22 ]] --[[ Name: Executed ]]
        if typeof(v2) ~= "string" then
            return;
        elseif v3 ~= "Enabled" and v3 ~= "Disabled" then
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
                if l_FirstChild_0 and l_FirstChild_0.Character then
                    local v10 = require(game.ReplicatedStorage.Modules.Ragdolls);
                    if v3 == "Enabled" then
                        v10.EnableRagdoll(l_FirstChild_0.Character);
                    elseif v3 == "Disabled" then
                        v10.DisableRagdoll(l_FirstChild_0.Character);
                    end;
                end;
            end;
            return;
        end;
	end,
};