--!strict
-- LOCATION: ServerScriptService/Modules/RebirthSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local RebirthSystem = {}

local PlayerController 
local UpgradesConfiguration = require(ReplicatedStorage.Modules.UpgradesConfiguration)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local SlotManager 

local BASE_POWER_COST = 1000 

function RebirthSystem.GetInfo(player: Player)
	local profile = PlayerController:GetProfile(player)
	if not profile then return 0, 0, 0, 0, 0 end

	local reb = profile.Data.Rebirths or 0

	local cost = BASE_POWER_COST * (math.pow(2, reb))

	-- Cash Multiplier scaling
	local currentCashMult = 1 + (reb * 0.5)
	local nextCashMult = 1 + ((reb + 1) * 0.5)

	-- Power Multiplier scaling
	local currentPowerMult = 1 + (reb * 0.25)
	local nextPowerMult = 1 + ((reb + 1) * 0.25)

	return cost, currentCashMult, nextCashMult, currentPowerMult, nextPowerMult
end

local function executeRebirth(player: Player, profile: any)
	profile.Data.Rebirths += 1

	profile.Data.Power = 0
	profile.Data.UnlockedWeights = {}

	for upgradeName, config in pairs(UpgradesConfiguration.Upgrades) do
		profile.Data[upgradeName] = config.DefaultValue
	end

	if player:FindFirstChild("leaderstats") then
		local ls = player.leaderstats
		if ls:FindFirstChild("Rebirths") then ls.Rebirths.Value = profile.Data.Rebirths end
		if ls:FindFirstChild("Power") then ls.Power.Value = profile.Data.Power end 
	end

	if player:FindFirstChild("UpgradesData") then
		for upgradeName, config in pairs(UpgradesConfiguration.Upgrades) do
			local stat = player.UpgradesData:FindFirstChild(upgradeName)
			if stat then stat.Value = config.DefaultValue end
		end
	end

	local function clearWeights(container: Instance?)
		if not container then return end
		for _, item in ipairs(container:GetChildren()) do
			if item:IsA("Tool") and item:GetAttribute("IsWeight") then
				item:Destroy()
			end
		end
	end

	clearWeights(player.Character)
	clearWeights(player:FindFirstChild("Backpack"))

	local UpgradesSystem = require(ServerScriptService.Modules.UpgradesSystem)
	UpgradesSystem.RefreshWalkSpeed(player)

	local Events = ReplicatedStorage:FindFirstChild("Events")
	local notif = Events and Events:FindFirstChild("ShowNotification")
	if notif then 
		-- Update notification to highlight both multipliers!
		local msg = string.format("Rebirth Successful! Cash: x%.2f | Power: x%.2f", 1 + (profile.Data.Rebirths * 0.5), 1 + (profile.Data.Rebirths * 0.25))
		notif:FireClient(player, msg, "Success") 
	end

	local updateEvent = Events:FindFirstChild("UpdateRebirthUI")
	if updateEvent then updateEvent:FireClient(player) end

	if UpgradesSystem and UpgradesSystem.UpdateClientUI then
		UpgradesSystem.UpdateClientUI(player)
	end

	if SlotManager then
		SlotManager.RefreshAllSlots(player)
	end

	local resetWeightsUI = Events and Events:FindFirstChild("ResetWeightsUI")
	if resetWeightsUI then resetWeightsUI:FireClient(player) end
end

function RebirthSystem.ForceRebirth(player: Player)
	local profile = PlayerController:GetProfile(player)
	if profile then
		executeRebirth(player, profile)
	end
end

function RebirthSystem.AttemptRebirth(player: Player)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	local currentMoney = profile.Data.Money or 0
	local cost, _, _, _, _ = RebirthSystem.GetInfo(player)

	if currentMoney >= cost then
		-- Deduct the cost from Money
		profile.Data.Money = currentMoney - cost
		if player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Money") then
			player.leaderstats.Money.Value = profile.Data.Money
		end
		executeRebirth(player, profile)
	else
		local Events = ReplicatedStorage:FindFirstChild("Events")
		local notif = Events and Events:FindFirstChild("ShowNotification")
		if notif then 
			notif:FireClient(player, "You need $" .. NumberFormatter.Format(cost) .. " to rebirth!", "Error") 
		end
	end
end

function RebirthSystem:Init(controllers)
	print("[RebirthSystem] Initialized (Dual Multipliers Added)")
	PlayerController = controllers.PlayerController

	local Modules = ServerScriptService:WaitForChild("Modules")
	SlotManager = require(Modules:WaitForChild("SlotManager"))

	local Events = ReplicatedStorage:WaitForChild("Events")
	if not Events:FindFirstChild("RequestRebirth") then
		local re = Instance.new("RemoteEvent")
		re.Name = "RequestRebirth"
		re.Parent = Events
	end

	if not Events:FindFirstChild("UpdateRebirthUI") then
		local re = Instance.new("RemoteEvent")
		re.Name = "UpdateRebirthUI"
		re.Parent = Events
	end

	Events.RequestRebirth.OnServerEvent:Connect(function(player)
		RebirthSystem.AttemptRebirth(player)
	end)
end

return RebirthSystem