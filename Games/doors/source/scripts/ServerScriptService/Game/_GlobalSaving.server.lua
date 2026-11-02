local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("GameData")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function EnsurePlayerStatsFolder(player)
	local playerStats = player:FindFirstChild("PlayerStats")
	if not playerStats then
		playerStats = Instance.new("Folder")
		playerStats.Name = "PlayerStats"
		playerStats.Parent = player
	end

	local function EnsureValue(propName, defaultValue, propType)
		local prop = playerStats:FindFirstChild(propName)
		if not prop then
			prop = Instance.new(propType)
			prop.Name = propName
			if propType == "IntValue" then
				prop.Value = defaultValue
			elseif propType == "BoolValue" then
				prop.Value = defaultValue
			elseif propType == "StringValue" then
				prop.Value = defaultValue
			end
			prop.Parent = playerStats
		end
	end
	
	EnsureValue("AdminPanel", false, "BoolValue")
	if game:GetService("RunService"):IsStudio() then
		EnsureValue("TypeRun", "Hotel", "StringValue")
	else
		EnsureValue("TypeRun", "Nonil", "StringValue")
	end
	
	EnsureValue("AchievementStat", "Join", "StringValue")

	EnsureValue("DoorOpened", 0, "IntValue")
	EnsureValue("Knobs", 0, "IntValue")
	EnsureValue("Revives", 0, "IntValue")
	EnsureValue("Deaths", 0, "IntValue")
	EnsureValue("TotalBoosts", 0, "IntValue")
	EnsureValue("RobuxSpend", 0, "IntValue")
	
	EnsureValue("isPremium", false, "BoolValue")
	EnsureValue("Rank", "Unranked", "StringValue")
	EnsureValue("ShowRanks", false, "BoolValue")

	EnsureValue("RushDeaths", 0, "IntValue")

	EnsureValue("RiftStore", false, "BoolValue")
	EnsureValue("RiftItem", "NoItem", "StringValue")
	EnsureValue("RiftItemDurability", 0, "IntValue")
	
	local Modifiers = Instance.new("Folder", player)
	Modifiers.Name = "Modifiers"

	for i,v in pairs(require(game.ReplicatedStorage.Modifiers)) do
		local bl = Instance.new("BoolValue", Modifiers)
		bl.Value = false
		bl.Name = i
	end
	
	local bl = Instance.new("IntValue", Modifiers)
	bl.Value = 0
	bl.Name = "KnobBonus"
end

local function SaveData(player)
	local success, result = pcall(function()
		local playerData = {
			AdminPanel = player.PlayerStats.AdminPanel.Value,
			TypeRun = player.PlayerStats.TypeRun.Value,
			
			AchievementStat = player.PlayerStats.AchievementStat.Value,
			
			DoorOpened = player.PlayerStats.DoorOpened.Value,
			Deaths = player.PlayerStats.Deaths.Value,
			Knobs = player.PlayerStats.Knobs.Value,
			ShowRanks = player.PlayerStats.ShowRanks.Value,
			TotalBoosts = player.PlayerStats.TotalBoosts.Value,
			Revives = player.PlayerStats.Revives.Value,
			RiftStore = player.PlayerStats.RiftStore.Value,
			RiftItem = player.PlayerStats.RiftItem.Value,
			RiftItemDurability = player.PlayerStats.RiftItemDurability.Value,
			isPremium = player.PlayerStats.isPremium.Value,
			RobuxSpend = player.PlayerStats.RobuxSpend.Value,
			RushDeaths = player.PlayerStats.RushDeaths.Value,
			Rank = player.PlayerStats.Rank.Value
		}
		DataStore:SetAsync("Player_"..player.UserId, playerData)
	end)

	if success then
		--print("Data saved for player: " .. player.Name)
	else
		warn("Failed to save data for player " .. player.Name .. ": " .. result)
	end
end

Players.PlayerAdded:Connect(function(player)
	EnsurePlayerStatsFolder(player)
	spawn(function()
		task.wait(4)

		if player.PlayerStats.TypeRun.Value == "Nonil" or player.PlayerStats.TypeRun.Value == "Lobby" then
			player:LoadCharacter()
			task.wait(1.5)
			game.ReplicatedStorage.UncopylockedHelper.UncopylockedHelper_Client:FireClient(player, "Failed_Run")
		end
	end)
	local playerData = DataStore:GetAsync("Player_"..player.UserId)
	local join_data = player:GetJoinData().TeleportData
	
	if playerData then
		if script.Parent.Name == "Lobby" then
			player.PlayerStats.TypeRun.Value = "Lobby"
		else
			player.PlayerStats.TypeRun.Value = playerData.TypeRun
		end
		
		player.PlayerStats.AchievementStat.Value = playerData.AchievementStat
		
		player.PlayerStats.AdminPanel.Value = playerData.AdminPanel
		player.PlayerStats.DoorOpened.Value = playerData.DoorOpened
		player.PlayerStats.Deaths.Value = playerData.Deaths
		player.PlayerStats.Knobs.Value = playerData.Knobs
		player.PlayerStats.ShowRanks.Value = playerData.ShowRanks
		player.PlayerStats.isPremium.Value = playerData.isPremium
		player.PlayerStats.TotalBoosts.Value = playerData.TotalBoosts
		player.PlayerStats.Revives.Value = playerData.Revives
		player.PlayerStats.RiftStore.Value = playerData.RiftStore
		player.PlayerStats.RiftItem.Value = playerData.RiftItem
		player.PlayerStats.RiftItemDurability.Value = playerData.RiftItemDurability
		player.PlayerStats.Rank.Value = playerData.Rank
		player.PlayerStats.RobuxSpend.Value = playerData.RobuxSpend
		player.PlayerStats.RushDeaths.Value = playerData.RushDeaths
		wait(2.5)
		if join_data ~= nil then
			local function load_hunt_value()
			join_data = join_data[player.Name]
			if join_data == nil then
				return
			end
			print(player.Name, "have join data:))")
			
			if join_data.Gold == nil then
				return
			end

		--[[	local function isNilValue(value)
				local v1 = join_data[value]
				if v1 == nil or v1 == {} then
					print("eh is nil")
					return false
				elseif v1 ~= nil then
					print("eh isn't nil")
					return true
					
				end
			end]]
			
			repeat wait(0.1) until player.Character
			
			player:WaitForChild("Stats").Gold.Value = join_data.Gold
			player.Character:FindFirstChild("Humanoid")
			player.Character:WaitForChild("Humanoid").Health = join_data.HP
		    for i,v in pairs(join_data.Items) do
				local item = game.ServerStorage:FindFirstChild(v.ItemID):Clone()
				item.Parent = player.Backpack
				if v.haveDurability == true then
					item:SetAttribute("Durability", v.Durability)
				end
			end
			print(
				join_data.Gold,
				join_data.Items,
				join_data.HP
			)
			
			end
			load_hunt_value()
		end
		player.PlayerStats.Knobs.Changed:Connect(function()
			ReplicatedStorage.Bricks.GetGold:FireClient(player, player.PlayerStats.Knobs.Value)
		end)
	else
		print("No data found for player: " .. player.Name)
	end
	
	
end)

Players.PlayerRemoving:Connect(function(player)
	SaveData(player)
end)

game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		SaveData(player)
	end
end)