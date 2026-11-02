-- Services
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local CollectionService = game:GetService("CollectionService")

-- Modules
local ProfileStoreModule = require(ServerScriptService.Modules.ProfileStore)
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local ItemManager
local SlotManager

-- [ CONFIGURATION ]
local DATA_VERSION = "ProjectData_v19"

local MAX_OFFLINE_TIME = 8 * 60 * 60
local INCOME_SCALING = 1.125
local VIP_TAG = "V.I.P"

-- 🔥 STATS BASE
local BASE_JUMPPOWER = 50
local BASE_WALKSPEED = 10

local MUTATION_MULTIPLIERS = {
	Normal = 1,
	Golden = 2,
	Diamond = 3,
	Ruby = 4,
	Neon = 5,
}

-- DATA TEMPLATE
local Template = {
	Money = 0,
	Speed = BASE_WALKSPEED,
	MaxCarry = 1,
	Rebirths = 0,
	BaseLevel = 0,
	LastSaveTime = 0,
	Inventory = {},
	Plots = { Floor1 = {}, Floor2 = {}, Floor3 = {} },
	DiscoveredItems = {},
	ClaimedPacks = {}
}

local GameProfileStore = ProfileStoreModule.New(DATA_VERSION, Template)

local PlayerController = {}
local profiles = {}
local vipCache = {}
local deadPlayers = {}

PlayerController.isShuttingDown = false

-- ===================== HELPERS =====================

function PlayerController:SetupSharedInstances()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	
	-- Create Events folder if it doesn't exist
	local Events = ReplicatedStorage:FindFirstChild("Events")
	if not Events then
		Events = Instance.new("Folder")
		Events.Name = "Events"
		Events.Parent = ReplicatedStorage
	end
	
	-- Create Functions folder if it doesn't exist
	local Functions = ReplicatedStorage:FindFirstChild("Functions")
	if not Functions then
		Functions = Instance.new("Folder")
		Functions.Name = "Functions"
		Functions.Parent = ReplicatedStorage
	end
end

function PlayerController:GetProfile(player)
	return profiles[player]
end

function PlayerController:AddMoney(player: Player, amount: number)
	local profile = profiles[player]
	if profile then
		profile.Data.Money += amount
		player.leaderstats.Money.Value = profile.Data.Money
	end
end

function PlayerController:DeductMoney(player: Player, amount: number): boolean
	local profile = profiles[player]
	if profile and profile.Data.Money >= amount then
		profile.Data.Money -= amount
		player.leaderstats.Money.Value = profile.Data.Money
		return true
	end
	return false
end

function PlayerController:IsVIP(player: Player): boolean
	if vipCache[player] ~= nil then
		return vipCache[player]
	end
	
	local hasTag = false
	for _, tag in ipairs(CollectionService:GetTags(player)) do
		if tag == VIP_TAG then
			hasTag = true
			break
		end
	end
	
	vipCache[player] = hasTag
	return hasTag
end

function PlayerController:IncrementBaseLevel(player: Player): number
	local profile = profiles[player]
	if profile then
		profile.Data.BaseLevel += 1
		return profile.Data.BaseLevel
	end
	return 0
end

-- ===================== PLAYER ADDED =====================

local function onPlayerAdded(player)
	local profile = GameProfileStore:StartSessionAsync(tostring(player.UserId), {
		Cancel = function() return player.Parent ~= Players end
	})

	if not profile then
		player:Kick("Data load failed.")
		return
	end

	profile:AddUserId(player.UserId)
	profile:Reconcile()
	profiles[player] = profile
	deadPlayers[player] = false

	-- Leaderstats
	local ls = Instance.new("Folder")
	ls.Name = "leaderstats"
	ls.Parent = player

	local money = Instance.new("IntValue")
	money.Name = "Money"
	money.Value = profile.Data.Money
	money.Parent = ls

	local speed = Instance.new("IntValue")
	speed.Name = "Speed"
	speed.Value = profile.Data.Speed
	speed.Parent = ls

	local rebirths = Instance.new("IntValue")
	rebirths.Name = "Rebirths"
	rebirths.Value = profile.Data.Rebirths
	rebirths.Parent = ls

	-- 🔥 CHARACTER ADDED (AQUÍ ESTÁ EL FIX)
	player.CharacterAdded:Connect(function(char)
		deadPlayers[player] = false

		local hum = char:WaitForChild("Humanoid")
		hum.UseJumpPower = true

		local reb = profile.Data.Rebirths or 0

		-- salto persistente x1.5 por rebirth
		hum.JumpPower = BASE_JUMPPOWER * (1.5 ^ reb)
		hum.WalkSpeed = profile.Data.Speed or BASE_WALKSPEED

		hum.Died:Connect(function()
			deadPlayers[player] = true
		end)
	end)
end

-- ===================== PLAYER REMOVING =====================

local function onPlayerRemoving(player)
	vipCache[player] = nil
	deadPlayers[player] = nil

	local profile = profiles[player]
	if profile then
		profile.Data.LastSaveTime = os.time()
		profile:EndSession()
	end

	profiles[player] = nil
end

-- ===================== INIT / START =====================

function PlayerController:Init(controllers)
	ItemManager = require(ServerScriptService.Modules.ItemManager)
	SlotManager = require(ServerScriptService.Modules.SlotManager)
	if SlotManager.Init then
		SlotManager:Init(controllers)
	end
end

function PlayerController:Start()
	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)

	for _, p in ipairs(Players:GetPlayers()) do
		task.spawn(onPlayerAdded, p)
	end

	game:BindToClose(function()
		for _, p in ipairs(Players:GetPlayers()) do
			if profiles[p] then
				profiles[p].Data.LastSaveTime = os.time()
			end
		end
	end)
end


function PlayerController:TestFunction()
	return "Test works!"
end

return PlayerController
