local DataStoreService = game:GetService("DataStoreService")
local playerData = DataStoreService:GetDataStore("PlayerData5")

local function onPlayerJoin(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local MurderElims = Instance.new("NumberValue")
	MurderElims.Name = "MW"
	MurderElims.Parent = leaderstats

	local sherifWins = Instance.new("NumberValue")
	sherifWins.Name = "SherifWins"
	sherifWins.Parent = leaderstats
	
	local innoWins = Instance.new("NumberValue")
	innoWins.Name = "IW"
	innoWins.Parent = leaderstats

	local deathEffectsEnabled = Instance.new("BoolValue")
	deathEffectsEnabled.Name = "DeathEffects"
	deathEffectsEnabled.Parent = leaderstats
	
	
	local playerUserId = "Player_" .. player.UserId
	local data = playerData:GetAsync(playerUserId)

	if data then
		MurderElims.Value = data['MW']
		sherifWins.Value = data['SherifWins']
		innoWins.Value = data["IW"]
        deathEffectsEnabled.Value = data["DeathEffects"]
	else
		MurderElims.Value = 0
		sherifWins.Value = 0
		innoWins.Value = 0
		deathEffectsEnabled.Value = true
	end
end



local function create_table(player)
	local player_stats = {}
	for _, stat in pairs(player.leaderstats:GetChildren()) do
		player_stats[stat.Name] = stat.Value
	end
	return player_stats
end



local function onPlayerExit(player)
	local player_stats = create_table(player)
	local success, err = pcall(function()
		local playerUserId = "Player_" .. player.UserId
		playerData:SetAsync(playerUserId, player_stats)
	end)



if not success then
	   warn("failure someones data has been lost.") -- lool
    end
end

game.Players.PlayerAdded:Connect(onPlayerJoin)
game.Players.PlayerRemoving:Connect(onPlayerExit)