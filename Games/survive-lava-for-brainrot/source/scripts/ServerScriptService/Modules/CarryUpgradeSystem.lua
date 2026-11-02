--!strict
-- LOCATION: ServerScriptService/Modules/CarryUpgradeSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local CarryUpgradeSystem = {}

-- [ MODULES ]
local PlayerController 
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations) 

-- [ CONFIG ]
local MAX_SLOTS = 6
local PRICES = {
	[1] = 50000,    -- Upgrade to 2
	[2] = 150000,   -- Upgrade to 3
	[3] = 350000,   -- Upgrade to 4
	[4] = 750000,   -- Upgrade to 5
	[5] = 1500000,  -- Upgrade to 6
}

-- Helper to find ID by level
local function getProductIdForLevel(level: number): number?
	-- Key Format: "CarryUpgrade_Lvl2", "CarryUpgrade_Lvl3", etc.
	local key = "CarryUpgrade_Lvl" .. tostring(level)
	local id = ProductConfigurations.Products[key]

	if not id then
		warn("[CarryUpgradeSystem] WARNING: Missing Product ID for key: '" .. key .. "' in ProductConfigurations!")
	end

	return id
end

-- [ PUBLIC API ]

local function applyUpgrade(player: Player, profile: any, newLevel: number)
	profile.Data.MaxCarry = newLevel
	CarryUpgradeSystem.UpdateClientUI(player)

	-- Refresh the Overhead GUI (0/2, 0/3 etc)
	local CarrySystem = require(ServerScriptService.Modules.CarrySystem)
	if CarrySystem and CarrySystem.RefreshGUI then
		CarrySystem.RefreshGUI(player)
	end
end

-- Called by Client (Cash)
function CarryUpgradeSystem.PurchaseUpgrade(player: Player)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	local current = profile.Data.MaxCarry or 1
	if current >= MAX_SLOTS then return end

	local price = PRICES[current] or 99999999

	if PlayerController:DeductMoney(player, price) then
		applyUpgrade(player, profile, current + 1)

		local Events = ReplicatedStorage:FindFirstChild("Events")
		local notif = Events and Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "Carry Capacity Upgraded!", "Success") end
	else
		local Events = ReplicatedStorage:FindFirstChild("Events")
		local notif = Events and Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "Not enough money!", "Error") end
	end
end

-- Called by Monetization (Robux)
function CarryUpgradeSystem.GrantUpgrade(player: Player, targetLevel: number)
	local profile = PlayerController:GetProfile(player)
	if not profile then return false end

	local current = profile.Data.MaxCarry or 1
	if current >= MAX_SLOTS then return false end

	applyUpgrade(player, profile, current + 1)
	return true
end

function CarryUpgradeSystem.UpdateClientUI(player: Player)
	local profile = PlayerController:GetProfile(player)

	local retries = 0
	while not profile and retries < 10 do
		task.wait(0.5)
		profile = PlayerController:GetProfile(player)
		retries += 1
	end

	if not profile then return end

	local current = profile.Data.MaxCarry or 1
	local nextPrice = PRICES[current]

	-- Find Next Robux ID
	local nextRobuxId = nil
	if current < MAX_SLOTS then
		nextRobuxId = getProductIdForLevel(current + 1)
	end

	local updateEvent = ReplicatedStorage.Events:FindFirstChild("UpdateCarryPrices")
	if updateEvent then
		updateEvent:FireClient(player, {
			Current = current,
			NextPrice = nextPrice,
			NextRobuxId = nextRobuxId,
			IsMax = (current >= MAX_SLOTS)
		})
	end
end

-- [ INIT ]

function CarryUpgradeSystem:Init(controllers)
	print("[CarryUpgradeSystem] Initialized")
	PlayerController = controllers.PlayerController

	local Events = ReplicatedStorage:WaitForChild("Events")

	local buyEvent = Events:FindFirstChild("PurchaseCarry")
	if not buyEvent then
		buyEvent = Instance.new("RemoteEvent")
		buyEvent.Name = "PurchaseCarry"
		buyEvent.Parent = Events
	end

	buyEvent.OnServerEvent:Connect(function(player)
		CarryUpgradeSystem.PurchaseUpgrade(player)
	end)

	local updateEvent = Events:FindFirstChild("UpdateCarryPrices")
	if not updateEvent then
		updateEvent = Instance.new("RemoteEvent")
		updateEvent.Name = "UpdateCarryPrices"
		updateEvent.Parent = Events
	end
end

function CarryUpgradeSystem:Start()
	local function onPlayerAdded(player)
		task.wait(1)
		CarryUpgradeSystem.UpdateClientUI(player)
	end

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(onPlayerAdded, player)
	end

	Players.PlayerAdded:Connect(onPlayerAdded)
end

return CarryUpgradeSystem