local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Network = require(ReplicatedStorage.Modules.Network)

local MASQUERADE = ReplicatedStorage.Assets.EventStorage["2025_MASQUERADE"]
local SPAWN_INTERVAL = 5
local MAX_CANDIES = 50
local DESPAWN_TIME = 300
local CANDY_VALUE = 1

local MasqueradeServer = {
	ActiveCandies = {},
	SpawnLocations = {},
	Running = false,
	SpawnFolder = nil,
	MapLoaded = false
}

function MasqueradeServer:GetPlayerProfile(player)
	if not player or not player:IsA("Player") then
		return nil
	end
	local l_PlayerData_0 = ServerStorage:FindFirstChild("PlayerData")
	if not l_PlayerData_0 then
		return nil
	end
	local l_Profile_0 = l_PlayerData_0:FindFirstChild(tostring(player.UserId))
	if not l_Profile_0 then
		return nil
	end
	return l_Profile_0
end

function MasqueradeServer:Init()
	print("[MasqueradeServer]: Initializing...")

	task.spawn(function()
		self:WaitForMap()
		self:LoadSpawnLocations()

		Network:SetConnection("CollectCurrencyAsync", "REMOTE_FUNCTION", function(player, positionTable)
			local position = Vector3.new(positionTable.X, positionTable.Y, positionTable.Z)
			return self:CollectCandy(player, position)
		end)

		if #self.SpawnLocations > 0 then
			self:Start()
		else
			warn("[MasqueradeServer]: No spawn locations found, event will not start")
		end
	end)
end

function MasqueradeServer:WaitForMap()
	print("[MasqueradeServer]: Waiting for map...")
	local map = workspace:WaitForChild("Map", 30)
	if not map then
		warn("[MasqueradeServer]: Map not found")
		return
	end

	local ingame = map:WaitForChild("Ingame", 30)
	if ingame then
		self.MapLoaded = true
		print("[MasqueradeServer]: Map loaded successfully")
	else
		warn("[MasqueradeServer]: Failed to find Ingame map")
	end
end

function MasqueradeServer:LoadSpawnLocations()
	if not self.MapLoaded then
		warn("[MasqueradeServer]: Cannot load spawn locations, map not loaded")
		return
	end

	print("[MasqueradeServer]: Looking for CurrencyLocations...")
	local spawnFolder = workspace.Map.Ingame:FindFirstChild("CurrencyLocations")
	if spawnFolder then
		local children = spawnFolder:GetChildren()
		print("[MasqueradeServer]: Found CurrencyLocations folder with " .. #children .. " children")

		self.SpawnFolder = spawnFolder
		self:UpdateSpawnLocations()

		if #self.SpawnLocations > 0 then
			print("[MasqueradeServer]: Loaded " .. #self.SpawnLocations .. " spawn locations from map")
		else
			warn("[MasqueradeServer]: CurrencyLocations folder is empty")
		end
	else
		warn("[MasqueradeServer]: No CurrencyLocations folder found in Ingame")
	end
end

function MasqueradeServer:UpdateSpawnLocations()
	table.clear(self.SpawnLocations)

	if self.SpawnFolder then
		for _, location in self.SpawnFolder:GetChildren() do
			if location:IsA("BasePart") then
				local locationData = {
					Position = location.Position,
					Size = location.Size
				}
				table.insert(self.SpawnLocations, locationData)
				print("[MasqueradeServer]: Added spawn location at " .. tostring(location.Position))
			end
		end
	end
end

function MasqueradeServer:Start()
	if self.Running then 
		print("[MasqueradeServer]: Already running")
		return 
	end

	if #self.SpawnLocations == 0 then
		warn("[MasqueradeServer]: Cannot start, no spawn locations available")
		return
	end

	self.Running = true
	print("[MasqueradeServer]: Event started with " .. MAX_CANDIES .. " max candies, spawn interval: " .. SPAWN_INTERVAL .. "s")

	task.spawn(function()
		while self.Running do
			local currentCandies = #self.ActiveCandies
			print("[MasqueradeServer]: Active candies: " .. currentCandies .. "/" .. MAX_CANDIES)

			if currentCandies < MAX_CANDIES and #self.SpawnLocations > 0 then
				self:SpawnCandy()
			end
			task.wait(SPAWN_INTERVAL)
		end
		print("[MasqueradeServer]: Spawn loop ended")
	end)
end

function MasqueradeServer:Stop()
	self.Running = false
	self:DespawnAllCandies()
	print("[MasqueradeServer]: Event stopped")
end

function MasqueradeServer:SpawnCandy()
	if #self.SpawnLocations == 0 then 
		warn("[MasqueradeServer]: No spawn locations available")
		return 
	end

	local randomLocationData = self.SpawnLocations[math.random(1, #self.SpawnLocations)]
	local basePosition = randomLocationData.Position
	local size = randomLocationData.Size

	local randomOffset = Vector3.new(
		math.random(-size.X/2, size.X/2),
		0,
		math.random(-size.Z/2, size.Z/2)
	)

	local spawnPosition = basePosition + randomOffset

	local candyData = {
		Position = spawnPosition,
		SpawnTime = tick()
	}

	table.insert(self.ActiveCandies, candyData)

	local positionTable = {
		X = spawnPosition.X,
		Y = spawnPosition.Y,
		Z = spawnPosition.Z
	}

	print("[MasqueradeServer]: Spawning candy at " .. tostring(spawnPosition))
	Network:FireAllConnections("ReplicateCandySpawnAsync", "REMOTE_EVENT", positionTable)
	print("[MasqueradeServer]: Network call sent, total candies: " .. #self.ActiveCandies)

	task.delay(DESPAWN_TIME, function()
		self:DespawnCandy(candyData)
	end)
end

function MasqueradeServer:CollectCandy(player, position)
	for i, candyData in ipairs(self.ActiveCandies) do
		if (candyData.Position - position).Magnitude < 5 then
			table.remove(self.ActiveCandies, i)

			local profile = self:GetPlayerProfile(player)
			if profile then
				profile.Data.EventCurrency = (profile.Data.EventCurrency or 0) + CANDY_VALUE
				print("[MasqueradeServer]: " .. player.Name .. " collected candy, total: " .. profile.Data.EventCurrency)
			end

			return true
		end
	end

	return false
end

function MasqueradeServer:DespawnCandy(candyData)
	for i, data in ipairs(self.ActiveCandies) do
		if data == candyData then
			table.remove(self.ActiveCandies, i)
			print("[MasqueradeServer]: Despawned candy, remaining: " .. #self.ActiveCandies)
			break
		end
	end
end

function MasqueradeServer:DespawnAllCandies()
	table.clear(self.ActiveCandies)
	Network:FireAllConnections("ReplicateCandyDespawnAsync", "REMOTE_EVENT")
	print("[MasqueradeServer]: All candies despawned")
end

return MasqueradeServer