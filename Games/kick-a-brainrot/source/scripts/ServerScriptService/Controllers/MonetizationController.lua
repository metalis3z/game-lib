--!strict
-- LOCATION: ServerScriptService/Controllers/MonetizationController

local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris") 

local MonetizationController = {}

local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations)
local UpgradesConfiguration = require(ReplicatedStorage.Modules.UpgradesConfiguration)
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local WeightConfigurations = require(ReplicatedStorage.Modules.WeightConfigurations) -- ## ADDED ##

local RebirthSystem 
local ItemManager 
local PlayerController 

local function playPurchaseEffects(player: Player)
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local effectEvent = Events and Events:FindFirstChild("TriggerUIEffect")
	if effectEvent then
		effectEvent:FireClient(player, "HighlightLight")
	end

	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local Templates = ReplicatedStorage:FindFirstChild("Templates")
	local confettiTemplate = Templates and Templates:FindFirstChild("Confetti")

	if root and confettiTemplate then
		local confetti = confettiTemplate:Clone()
		confetti.Parent = root
		for _, child in ipairs(confetti:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child:Emit(child:GetAttribute("EmitCount") or 50)
			end
		end
		Debris:AddItem(confetti, 3)
	end
end

function MonetizationController.ProcessReceipt(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then return Enum.ProductPurchaseDecision.NotProcessedYet end

	local productId = receiptInfo.ProductId
	local productName = ProductConfigurations.GetProductById(productId)
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local notif = Events and Events:FindFirstChild("ShowNotification")

	local upgradeType = UpgradesConfiguration.GetUpgradeByProductId(productId)
	if upgradeType then
		local upgradeAmount = 1 

		if not PlayerController then PlayerController = require(ServerScriptService.Controllers.PlayerController) end
		local profile = PlayerController:GetProfile(player)

		if profile then
			local config = UpgradesConfiguration.Upgrades[upgradeType]
			local currentVal = profile.Data[upgradeType] or config.DefaultValue

			profile.Data[upgradeType] = currentVal + upgradeAmount

			if player:FindFirstChild("leaderstats") then
				local stat = player.leaderstats:FindFirstChild(upgradeType)
				if stat then stat.Value = profile.Data[upgradeType] end
			end

			local UpgradesSystem = require(ServerScriptService.Modules.UpgradesSystem)
			UpgradesSystem.UpdateClientUI(player)

			if notif then notif:FireClient(player, "+" .. upgradeAmount .. " " .. config.DisplayName .. " Purchased!", "Success") end
			playPurchaseEffects(player)
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	-- [[ WEIGHTS HANDLING ]] --
	for weightName, data in pairs(WeightConfigurations.Weights) do
		if data.ProductId == productId then
			if not PlayerController then PlayerController = require(ServerScriptService.Controllers.PlayerController) end
			local profile = PlayerController:GetProfile(player)

			if profile then
				if not profile.Data.UnlockedWeights[weightName] then
					profile.Data.UnlockedWeights[weightName] = true

					-- Lazy load WeightsController
					local WeightsController = require(ServerScriptService.Controllers.WeightsController)
					WeightsController.GiveWeightTool(player, weightName, data.Power)

					if notif then notif:FireClient(player, weightName .. " Purchased!", "Success") end

					local updateUI = Events and Events:FindFirstChild("UpdateWeightsUI")
					if updateUI then updateUI:FireClient(player, weightName) end

					playPurchaseEffects(player) 
					return Enum.ProductPurchaseDecision.PurchaseGranted
				else
					return Enum.ProductPurchaseDecision.PurchaseGranted -- Handled (already owned)
				end
			end
		end
	end

	if not productName then return Enum.ProductPurchaseDecision.NotProcessedYet end

	-- [[ LIMITED ITEM HANDLING ]]
	if productName == "LimitedItem" then
		local LimitedItemController = require(ServerScriptService.Controllers.LimitedItemController)

		if LimitedItemController:DecrementStock() then
			if not ItemManager then ItemManager = require(ServerScriptService.Modules.ItemManager) end

			local reward = ProductConfigurations.LimitedItem.Reward
			local itemConf = ItemConfigurations.GetItemData(reward.Name)
			local rarity = itemConf and itemConf.Rarity or "Common"

			ItemManager.GiveItemToPlayer(player, reward.Name, reward.Mutation, rarity, reward.Level)

			if notif then notif:FireClient(player, "Limited Item Purchased!", "Success") end
			playPurchaseEffects(player) 

			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			if notif then notif:FireClient(player, "Item is Sold Out!", "Error") end
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
	end

	if productName == "DoubleOffline" then
		if not PlayerController then PlayerController = require(ServerScriptService.Controllers.PlayerController) end
		local pending = PlayerController.PendingOfflineEarnings[player]

		if pending and pending > 0 then
			PlayerController:AddMoney(player, pending * 2)
			PlayerController.PendingOfflineEarnings[player] = nil

			if notif then notif:FireClient(player, "Offline Earnings DOUBLED!", "Success") end
			playPurchaseEffects(player) 

			local hideEv = Events:FindFirstChild("HideOfflineUI")
			if hideEv then hideEv:FireClient(player) end

			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
	end

	if productName == "SkipRebirth" then
		if not RebirthSystem then RebirthSystem = require(ServerScriptService.Modules.RebirthSystem) end
		RebirthSystem.ForceRebirth(player)
		playPurchaseEffects(player) 
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local itemReward = ProductConfigurations.ItemProductRewards[productName]
	if itemReward then
		if not ItemManager then ItemManager = require(ServerScriptService.Modules.ItemManager) end

		local itemConf = ItemConfigurations.GetItemData(itemReward.Name)
		local rarity = itemConf and itemConf.Rarity or "Common"

		ItemManager.GiveItemToPlayer(player, itemReward.Name, itemReward.Mutation, rarity, itemReward.Level)

		if notif then notif:FireClient(player, itemReward.Name .. " Purchased!", "Success") end
		playPurchaseEffects(player) 
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local cashAmount = ProductConfigurations.CashProductRewards[productName]
	if cashAmount then
		if not PlayerController then PlayerController = require(ServerScriptService.Controllers.PlayerController) end
		PlayerController:AddMoney(player, cashAmount)
		local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
		if notif then notif:FireClient(player, "$" .. NumberFormatter.Format(cashAmount) .. " Purchased!", "Success") end
		playPurchaseEffects(player) 
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	if productName == "RandomItem" then
		if not ItemManager then ItemManager = require(ServerScriptService.Modules.ItemManager) end

		local validItems = {}
		for itemName, data in pairs(ItemConfigurations.Items) do
			if data.Rarity ~= "Common" and data.Rarity ~= "Uncommon" then
				table.insert(validItems, {Name = itemName, Rarity = data.Rarity})
			end
		end

		if #validItems > 0 then
			local chosenItem = validItems[math.random(1, #validItems)]
			ItemManager.GiveItemToPlayer(player, chosenItem.Name, "Normal", chosenItem.Rarity, 1)

			if notif then 
				notif:FireClient(player, "You unboxed a " .. chosenItem.Rarity .. " " .. chosenItem.Name .. "!", "Success") 
			end
			playPurchaseEffects(player) 

			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			warn("[MonetizationController] No valid items found for RandomItem product!")
		end
	end

	if productName == "Revive" then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	if productName == "SpinsX3" or productName == "SpinsX9" then
		if not PlayerController then PlayerController = require(ServerScriptService.Controllers.PlayerController) end
		local profile = PlayerController:GetProfile(player)
		if profile then
			local spinAmount = (productName == "SpinsX3") and 3 or 9
			profile.Data.SpinNumber = (profile.Data.SpinNumber or 0) + spinAmount
			player:SetAttribute("SpinNumber", profile.Data.SpinNumber)

			if notif then notif:FireClient(player, "+" .. spinAmount .. " Spins Purchased!", "Success") end
			playPurchaseEffects(player) 
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
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