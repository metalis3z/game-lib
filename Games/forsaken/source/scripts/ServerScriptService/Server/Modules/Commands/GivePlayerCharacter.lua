-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw
local v0 = {
    Title = "Give Player Character", 
    LayoutOrder = -1, 
	Executable = true, 
	AllowedInVIP = false,
	RequiredRank = "HeadModerator",
	Executed = function(_, _, v2, v3) --[[ Line: 24 ]] --[[ Name: Executed ]]
		if typeof(v2) ~= "string" then
			return;
		elseif typeof(v3) ~= "string" then
			return;
		else
			local data = string.split(v3, "/")
			if typeof(data[1]) == "string" and typeof(data[2]) == "string" then
				local charType = data[1]
				local charName = data[2]
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
					if player and player:FindFirstChild("PlayerData") and player.PlayerData:FindFirstChild("Purchased") and player.PlayerData.Purchased:FindFirstChild(charType) and not player.PlayerData.Purchased:FindFirstChild(charType):FindFirstChild(charName) then
						Instance.new("IntValue", player.PlayerData.Purchased:FindFirstChild(charType)).Name = charName
					else
						return
					end
				end
				return
			else
				return
			end
		end;
	end
};

v0.Parameters = {
	[1] = {
		Title = "Chosen Player", 
		Type = "String", 
		DefaultValue = "...", 
		--Metadata = {
		--	AllPlayersOptionDisabled = true
		--}
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
}

return v0