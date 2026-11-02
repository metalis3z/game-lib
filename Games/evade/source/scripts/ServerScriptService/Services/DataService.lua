--!strict

local DataService: any = {}

local DataStoreService = game:GetService("DataStoreService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local DataStore = DataStoreService:GetDataStore("DataTest123")
local DefaultStats = require(ServerScriptService.Components.DefaultStats)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local TableUtils = require(ReplicatedStorage.Utils.TableUtils)

local function DeepCopy(Table)
	local NewTable = {}
	for Key, Value in pairs(Table) do
		if type(Value) == "table" then
			NewTable[Key] = DeepCopy(Value)
		else
			NewTable[Key] = Value
		end
	end
	return NewTable
end

function DataService:SavePlayer(player: Player)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return
	end
	playerChannel:Set("LastLogoutTime", os.time())
	local _, data = playerChannel:Get("Data")
	pcall(function()
		DataStore:SetAsync(player.UserId, data)
	end)
end

function DataService:ResetData(player: Player)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false
	end

	local newData = DeepCopy(DefaultStats)

	for key, value in pairs(newData) do
		playerChannel:Set(key, value)
	end

	pcall(function()
		DataStore:SetAsync(player.UserId, newData)
	end)

	player:Kick("Profile session end - Please rejoin")
	return true
end

function DataService:SetKey(player: Player, key: string, value: any)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false
	end

	playerChannel:Set(key, value)

	return true
end

function DataService:Start()
	Synchronizer:Create("Cycle", { Overrides = {} })

	local function setupPlayer(player: Player)
		if Synchronizer:Get(player) then
			return
		end

		local success, savedData = pcall(function()
			return DataStore:GetAsync(player.UserId)
		end)

		if not success then
			return player:Kick("There was an error loading your data, please rejoin.")
		end

		local playerData = savedData or DeepCopy(DefaultStats)
		playerData = TableUtils.Reconcile(playerData, DefaultStats)

		if playerData.AnimalPodiums then
			for podiumIndex, status in pairs(playerData.AnimalPodiums) do
				if status == "Reserved" then
					playerData.AnimalPodiums[podiumIndex] = "Empty"
				end
			end
		end

		for name, data in pairs(DefaultStats) do
			if playerData[name] == nil then
				playerData[name] = data
			end
		end

		playerData.TimesJoined += 1

		for _, data in pairs(playerData.AnimalPodiums) do
			if data.Steal then
				data.Steal = nil
			end
			if data.Traits and #data.Traits > 1 then
				local uniqueTraits = {}
				local seen = {}
				for _, trait in ipairs(data.Traits) do
					if not seen[trait] then
						seen[trait] = true
						table.insert(uniqueTraits, trait)
					end
				end
				data.Traits = uniqueTraits
			end
		end

		local playerChannel = Synchronizer:Create(player, playerData)
		playerChannel:AddListener(player)
	end

	Players.PlayerAdded:Connect(setupPlayer)

	Players.PlayerRemoving:Connect(function(player)
		task.spawn(function()
			DataService:SavePlayer(player)
			Synchronizer:Destroy(player)
		end)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(setupPlayer, player)
	end

	task.spawn(function()
		while task.wait(120) do
			for _, player: Player in pairs(Players:GetPlayers()) do
				task.spawn(function()
					local playerChannel = Synchronizer:Get(player)
					if not playerChannel then
						return
					end
					playerChannel:Set("LastLogoutTime", os.time())
					local _, data = playerChannel:Get("Data")
					pcall(function()
						DataStore:SetAsync(player.UserId, data)
					end)
				end)
			end
		end
	end)
end

return DataService
