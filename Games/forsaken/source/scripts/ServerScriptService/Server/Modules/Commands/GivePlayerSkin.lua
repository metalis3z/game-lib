-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw
local v0 = {
	Title = "Give Player Skin", 
	LayoutOrder = -2, 
	Executable = true, 
	AllowedInVIP = false,
	RequiredRank = "Moderator",
	Executed = function(_, _, v2, v3) --[[ Line: 24 ]] --[[ Name: Executed ]]
		if typeof(v2) ~= "string" then
			return;
		elseif typeof(v3) ~= "string" then
			return;
		else
			local players = {
				v2
			}
			if v2 == "All" then
				players = {}
				for i, v in ipairs(game.Players:GetPlayers()) do
					table.insert(players, v)
				end
			end
			for i, v in ipairs(players) do
				local player = typeof(v) == "Instance" and v:IsA("Player") and v or game.Players:FindFirstChild(v)
				if player and player:FindFirstChild("PlayerData") and player.PlayerData:FindFirstChild("Purchased") and player.PlayerData.Purchased:FindFirstChild("Skins") and not player.PlayerData.Purchased.Skins:FindFirstChild(v3) then
					Instance.new("IntValue", player.PlayerData.Purchased.Skins).Name = v3
				else
					return
				end
			end
			return
	end;
	end
};

v0.Parameters = {
	[1] = {
		Title = "Chosen Player", 
		Type = "String", 
		DefaultValue = "...", 
	},
	[2] = {
		Title = "Chosen Skin", 
		Type = "Textbox", 
		DefaultValue = "DignityNoli", 
		--Metadata = {
		--	Options = function() --[[ Line: 21 ]] --[[ Name: Options ]]
		--		local v0 = {};
		--		for _, v2 in pairs({
		--			game.ReplicatedStorage.Assets.Skins.Killers, 
		--			game.ReplicatedStorage.Assets.Skins.Survivors
		--			}) do
		--			for _, v4 in pairs(v2:GetChildren()) do
		--				for _, v5 in pairs(v4:GetChildren()) do
		--					table.insert(v0, (("%*/%*/%*"):format(v2.Name, v4.Name, v5.Name)));
		--				end
		--			end;
		--		end;
		--		return table.concat(v0, "|");
		--	end
		--}
	}, 
}

return v0