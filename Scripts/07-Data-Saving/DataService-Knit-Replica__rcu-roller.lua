-- Reference copy for study. Game: RCU (roll / mounts) (rcu-roller)
-- Original: ServerScriptService/Services/DataService.lua  (506 lines)
-- What it does: Knit service with a very large commented default template, deep reconcile, path-based Set/Increment through a Replica, 5-minute autosave, and a 1-second boost countdown.

--[[
	DataService — Player data management with DataStoreService + ReplicaServer
	Handles loading, saving, default data template, and replication to clients
]]

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local ReplicaServer = require(game:GetService("ServerScriptService").Modules.ReplicaServer)

local IS_STUDIO = RunService:IsStudio()
local AUTOSAVE_INTERVAL = 300 -- 5 minutes
local DATA_STORE_NAME = "PlayerData_v2"

local DataStore = DataStoreService:GetDataStore(DATA_STORE_NAME)

------------------------------------------------------------------------
-- Default Data Template (inferred from all client controllers)
------------------------------------------------------------------------
local DEFAULT_DATA = {
	-- Currency
	clicks = 0,
	gems = 0,
	
	-- Progression
	rebirths = 0,
	tutorialStage = 10,
	day = 0,
	lastLogin = 0,
	
	-- Pets
	pets = {},
	equippedPets = {},
	
	-- Inventory (items by category)
	inventory = {
		pet = {},
		exclusive = {},
		potion = {},
		fruit = {},
		auraDice = {},
		box = {},
		exclusiveEgg = {},
		mapItem = {},
		activeEvent = {},
		aura = {},
		mount = {},
		booth = {},
		upgrade = {},
		gamepass = {},
	},
	
	-- Equipped items
	equippedAura = "",
	equippedMount = "",
	equippedTitle = "",
	equippedBooth = "defaultBooth",
	isMountEquipped = false,
	isAxeEquipped = false,
	isAutoClicking = false,
	isAutoRebirthing = false,
	selectedAutoRebirth = 0,
	
	-- Upgrades (purchased upgrade levels)
	upgrades = {
		-- Machine upgrades (Shared.List.Upgrades — bought with gems)
		freeAutoClicker = false,
		rebirthButtons = 0,
		clicksMultiplier = 0,
		luckMultiplier = 0,
		petEquip = 0,
		goldenPetsLuck = 0,
		epicClicks = 0,
		toxicPetsLuck = 0,
		aurasLuck = 0,
		-- Passive upgrade bonuses (Items.Upgrades — from achievements/prestige/clans)
		gemsMultiplier = 0,
		rebirthsMultiplier = 0,
		hatchSpeed = 0,
		petsEquipped = 0,
		auraLuck = 0,
		shinyPetsLuck = 0,
		mythicalPity = 0,
	},
	
	-- Gamepasses owned
	passes = {
		autoClicker = false,
		autoRebirth = false,
		petEquip2 = false,
		petEquip3 = false,
		fasterEggsOpen = false,
		magicEggs = false,
		megaLuck = false,
		ultraLuck = false,
		vip = false,
		insaneFarmer = false,
		shinyHunter = false,
		extraEgg = false,
	},
	
	-- Maps
	maps = { [1] = true },
	mapQuests = {},
	
	-- Farms
	farms = {},
	
	-- Trees
	trees = {},
	
	-- Buildings
	buildings = {},
	
	-- Quests
	quests = {},
	
	-- Clans
	clanId = "",
	clanBuildings = {},
	
	-- Settings
	settings = {
		muteSounds = false,
		muteMusic = false,
		hidePopups = false,
		extraHatchingSounds = true,
	},
	
	-- Pity system
	pity = {},
	
	-- Ancient Shop purchases
	ancientShop = {
		extraEggOpen = false,
		extraItemBox = false,
	},
	
	-- City light switches
	lightSwitches = {},
	
	-- Stats
	stats = {
		totalClicks = 0,
		totalEggsOpened = 0,
		timePlayed = 0,
		robuxSpent = 0,
		ancientWheelSpins = 0,
		auraRolls = 0,
		eggsOpened = 0,
		playtimeRewards = 0,
		fruitsCollected = 0,
		treesDestroyed = 0,
		exclusiveEggsOpened = 0,
		rarities = {
			common = 0,
			uncommon = 0,
			rare = 0,
			epic = 0,
			legendary = 0,
			mythical = 0,
			eternal = 0,
			secret = 0,
			exclusive = 0,
		},
	},
	
	-- Prestige / Index
	index = {},
	indexClaimed = {},
	prestige = 0,
	prestigeXp = 0,
	prestigeActivities = {},
	prestigeClaimed = {},
	
	-- Active effects
	activeEffects = {},
	
	-- Codes redeemed
	redeemedCodes = {},
	
	-- Leaderboard
	leaderboardBanned = false,
	
	-- Supporter pack
	supporterProgress = 0,
	supporterPackTier = 0,

	-- Release stock
	releaseStock = {},
	
	-- Tutorial
	tutorialCompleted = false,
	
	-- Update log
	lastUpdateNumber = 0,
	
	-- Active boosts (potions/events with expiry timestamps)
	activeBoosts = {},
	
	-- Friends bonus
	friendsInServer = 0,
	
	-- Aura XP
	auraXp = 0,
	
	-- Axe / Wood (TreeService)
	axe = "woodenAxe",
	wood = 0,
	
	-- Archived pets
	archivedPets = {},
	autoArchive = {},
	
	-- Auto hatching
	autoHatching = "",
	isAutoRebirthing = false,
	-- Clan weekly boosts
	clanWeeklyBoosts = {},
	
	-- Shadow ban
	shadowBanExpires = 0,
	
	-- Trading
	tradeRequests = {},
	
	-- Trading Plaza booth
	boothOffers = {},
	
	-- Achievements & Index rewards
	claimedAchievements = {},
	claimedIndexRewards = {},
	
	-- Session / Playtime rewards
	sessionTime = 0,
	claimedPlaytimeRewards = {},
	dayReset = 0,
	
	-- Mini Chests
	miniChests = {},
	
	-- Chests (timed cooldown)
	chests = {},
	
	-- RCX Rewards
	rcxTier = 0,
	hasClaimedRCXTier = false,
	hasCheckedRCXTier = false,
	
	-- Exclusive Items (shop stock tracking)
	exclusiveItems = {},
	
	-- Profile creation timestamp (ms)
	profileCreateTime = 0,
	
	-- Trading session data
	sentTradeRequests = {},
	hasTradesFrom = {},
	tradesLocked = false,
	tradeSetting = 1,
	isTrading = false,
}

------------------------------------------------------------------------
-- Deep reconcile: add missing keys from template without overwriting existing
------------------------------------------------------------------------
local function reconcile(data, template)
	for key, defaultValue in template do
		if data[key] == nil then
			if type(defaultValue) == "table" then
				data[key] = table.clone(defaultValue)
			else
				data[key] = defaultValue
			end
		elseif type(defaultValue) == "table" and type(data[key]) == "table" then
			reconcile(data[key], defaultValue)
		end
	end
end

------------------------------------------------------------------------
-- DataService Knit Service
------------------------------------------------------------------------
local DataService = Knit.CreateService({
	Name = "DataService",
	Client = {},
	
	_playerData = {},
	_playerReplicas = {},
	_playerLoaded = {},
})

function DataService:GetData(player)
	return self._playerData[player]
end

function DataService:GetReplica(player)
	return self._playerReplicas[player]
end

function DataService:IsLoaded(player)
	return self._playerLoaded[player] == true
end

function DataService:WaitForData(player)
	while not self._playerLoaded[player] do
		task.wait(0.1)
	end
	return self._playerData[player]
end

function DataService:Set(player, path, value)
	local replica = self._playerReplicas[player]
	if not replica then return end
	replica:Set(path, value)
end

function DataService:SetValues(player, path, values)
	local replica = self._playerReplicas[player]
	if not replica then return end
	replica:SetValues(path, values)
end

function DataService:Increment(player, path, amount)
	local data = self._playerData[player]
	if not data then return end
	
	local current = data
	for i = 1, #path - 1 do
		current = current[path[i]]
		if not current then return end
	end
	local key = path[#path]
	local oldVal = current[key] or 0
	local newVal = oldVal + amount
	
	self:Set(player, path, newVal)
	return newVal
end

------------------------------------------------------------------------
-- Load / Save
------------------------------------------------------------------------
function DataService:_loadData(player)
	local key = "Player_" .. player.UserId
	local data
	
	local success, err = pcall(function()
		data = DataStore:GetAsync(key)
	end)
	
	if not success then
		warn("[DataService] Failed to load data for", player.Name, ":", err)
		player:Kick("Failed to load your data. Please rejoin.")
		return nil
	end
	
	if data == nil then
		data = {}
	end
	
	reconcile(data, DEFAULT_DATA)
	data.lastLogin = os.time()
	if data.profileCreateTime == 0 then
		data.profileCreateTime = os.time() * 1000
	end
	
	return data
end

function DataService:_saveData(player)
	if not self._playerLoaded[player] then return false end
	
	local data = self._playerData[player]
	if not data then return false end
	local key = "Player_" .. player.UserId
	local success, err = pcall(function()
		DataStore:SetAsync(key, data)
	end)
	
	if not success then
		warn("[DataService] Failed to save data for", player.Name, ":", err)
		return false
	end
	
	return true
end

------------------------------------------------------------------------
-- Player lifecycle
------------------------------------------------------------------------
function DataService:_onPlayerAdded(player)
	local data = self:_loadData(player)
	if not data then return end
	
	self._playerData[player] = data
	
	local replica = ReplicaServer.NewReplica({
		Token = "playerData",
		Tags = { Player = player },
		Data = data,
		Replication = player,
	})
	
	self._playerReplicas[player] = replica
	self._playerLoaded[player] = true
	
	print("[DataService] Loaded data for", player.Name)
end

function DataService:_onPlayerRemoving(player)
	if self._playerLoaded[player] then
		self:_saveData(player)
	end
	
	local replica = self._playerReplicas[player]
	if replica then
		replica:Destroy()
	end
	
	self._playerData[player] = nil
	self._playerReplicas[player] = nil
	self._playerLoaded[player] = nil
end

function DataService:_startAutosave()
	task.spawn(function()
		while true do
			task.wait(AUTOSAVE_INTERVAL)
			for player in self._playerData do
				if player.Parent then
					task.spawn(function()
						self:_saveData(player)
					end)
				end
			end
		end
	end)
end

------------------------------------------------------------------------
-- Knit lifecycle
------------------------------------------------------------------------
function DataService:KnitInit()
end

function DataService:KnitStart()
	for _, player in Players:GetPlayers() do
		task.spawn(function()
			self:_onPlayerAdded(player)
		end)
	end
	
	Players.PlayerAdded:Connect(function(player)
		self:_onPlayerAdded(player)
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		self:_onPlayerRemoving(player)
	end)
	
	game:BindToClose(function()
		for player in self._playerData do
			task.spawn(function()
				self:_saveData(player)
			end)
		end
		task.wait(3)
	end)
	
	self:_startAutosave()
	self:_startBoostTick()
	
	print("[DataService] Started")
end

function DataService:_startBoostTick()
	task.spawn(function()
		while true do
			task.wait(1)
			for player, data in self._playerData do
				-- Track timePlayed for achievements
				local newTime = (data.stats and data.stats.timePlayed or 0) + 1
				self:Set(player, {"stats", "timePlayed"}, newTime)

				-- Boost countdown
				if not data.activeBoosts then continue end
				for boostName, remaining in data.activeBoosts do
					if type(remaining) == "number" then
						local newVal = remaining - 1
						if newVal <= 0 then
							self:Set(player, {"activeBoosts", boostName}, nil)
						else
							self:Set(player, {"activeBoosts", boostName}, newVal)
						end
					end
				end
			end
		end
	end)
end

return DataService
