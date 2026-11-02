-- Reference copy for study. Game: Survive LAVA for Brainrot (survive-lava-for-brainrot)
-- Original: ServerScriptService/Controllers/MonetizationController.lua  (101 lines)
-- What it does: Readable receipt controller: product name from a config module, then reward tables for speed, items, carry upgrades and cash, with lazy-required systems and a client notification.

--!strict
-- LOCATION: ServerScriptService/Controllers/MonetizationController

local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local MonetizationController = {}

-- [ MODULES ]
local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations)
local RebirthSystem 
local ItemManager 
local PlayerController 
local TsunamiManager 
local SpeedSystem
local CarryUpgradeSystem -- ## ADDED ##

function MonetizationController.ProcessReceipt(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then return Enum.ProductPurchaseDecision.NotProcessedYet end

	local productId = receiptInfo.ProductId
	local productName = ProductConfigurations.GetProductById(productId)
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local notif = Events and Events:FindFirstChild("ShowNotification")

	-- 1. REBIRTH SKIP
	if productName == "SkipRebirth" then
		if not RebirthSystem then RebirthSystem = require(ServerScriptService.Modules.RebirthSystem) end
		RebirthSystem.ForceRebirth(player)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	-- 2. MEGA TSUNAMI
	if productName == "MegaTsunami" then
		if not TsunamiManager then TsunamiManager = require(ServerScriptService.Modules.TsunamiManager) end
		TsunamiManager.ForceSpawn("Mega", player)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	-- 3. SPEED PRODUCTS
	local speedAmount = ProductConfigurations.SpeedProductRewards[productName]
	if speedAmount then
		if not SpeedSystem then SpeedSystem = require(ServerScriptService.Modules.SpeedSystem) end
		SpeedSystem.GrantSpeed(player, speedAmount)
		if notif then notif:FireClient(player, "+" .. speedAmount .. " Speed Purchased!", "Success") end
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	-- 4. ## ADDED: CARRY UPGRADES ##
	local targetLevel = ProductConfigurations.CarryUpgradeMap[productName]
	if targetLevel then
		if not CarryUpgradeSystem then CarryUpgradeSystem = require(ServerScriptService.Modules.CarryUpgradeSystem) end

		-- Use the Grant Function
		local success = CarryUpgradeSystem.GrantUpgrade(player, targetLevel)

		if success then
			if notif then notif:FireClient(player, "Carry Capacity Upgraded!", "Success") end
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			-- If they somehow bought an upgrade for a level they already have or isn't next
			-- We grant it anyway to avoid taking money for nothing, or we can handle logic inside GrantUpgrade to force next level
			-- For now, we assume GrantUpgrade handles it gracefully.
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
	end

	-- 5. ITEM PRODUCTS
	local itemReward = ProductConfigurations.ItemProductRewards[productName]
	if itemReward then
		if not ItemManager then ItemManager = require(ServerScriptService.Modules.ItemManager) end
		ItemManager.GiveItemToPlayer(player, itemReward.Name, itemReward.Mutation, itemReward.Rarity, itemReward.Level)
		if notif then notif:FireClient(player, itemReward.Name .. " Purchased!", "Success") end
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	-- 6. CASH PRODUCTS
	local cashAmount = ProductConfigurations.CashProductRewards[productName]
	if cashAmount then
		if not PlayerController then PlayerController = require(ServerScriptService.Controllers.PlayerController) end
		PlayerController:AddMoney(player, cashAmount)
		local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
		if notif then notif:FireClient(player, "$" .. NumberFormatter.Format(cashAmount) .. " Purchased!", "Success") end
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	return Enum.ProductPurchaseDecision.NotProcessedYet
end

function MonetizationController:Init(controllers)
	print("[MonetizationController] Initialized")
end

function MonetizationController:Start()
	MarketplaceService.ProcessReceipt = MonetizationController.ProcessReceipt
end

return MonetizationController
