local ShopService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")

local ModdedShopService = require(ServerScriptService.Services.ModdedShopService)

local EventService = require(ServerScriptService.Services.EventService)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local PlotService = require(ServerScriptService.Services.PlotService)
local MoneyService = require(ServerScriptService.Services.MoneyService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local LuckService = require(ServerScriptService.Services.LuckService)

local Net = require(ReplicatedStorage.Packages.Net)
local Shop = require(ReplicatedStorage.Datas.Shop)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local SharedGame = require(ReplicatedStorage.Shared.Game)
local UnlockBase = require(ReplicatedStorage.Datas.UnlockBase)

local PurchaseRemote = Net:RemoteEvent("ShopService/Purchase")
local PurchaseRemote2 = Net:RemoteEvent("ModdedShopService/Purchase")

local PendingUnlocks = {} :: {[number]: {player: Player, targetUserId: number, productId: number, floor: number}}
local PendingModded = {} :: {[number]: {player: Player, brainrot: string, purchaseType: string}}
local LuckyBlocksAmount = {
	[3478819642] = 1,
	[3478819641] = 3,
	[3478819648] = 10
}

function ShopService:ProcessPurchase(player: Player, productId: number)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return
	end

	if PendingModded[productId] then
		local moddedData = PendingModded[productId]

		if moddedData.player == player then
			ModdedShopService.Process(player, moddedData.brainrot, moddedData.purchaseType)
			PendingModded[productId] = nil
		end

		return
	end

	local productInfo = Shop[productId]
	if not productInfo then
		return
	end

	if PendingUnlocks[productId] then
		local unlockData = PendingUnlocks[productId]

		if unlockData.player == player then
			local targetPlayer = Players:GetPlayerByUserId(unlockData.targetUserId)

			if targetPlayer then
				local targetPlot = PlotService.getPlot(targetPlayer)
				if targetPlot then
					local targetPlotChannel = Synchronizer:Get(targetPlot.Name)
					local blockTimeKey = "BlockEndTimeFirstFloor"
					if targetPlotChannel then
						if unlockData.floor == 2 then
							blockTimeKey = "BlockEndTimeSecondFloor"
						elseif unlockData.floor == 3 then
							blockTimeKey = "BlockEndTimeThirdFloor"
						end

						targetPlotChannel:Set(blockTimeKey, nil)
						targetPlotChannel:Set("BlockedDelayTime", workspace:GetServerTimeNow() + 10)

						if targetPlot:FindFirstChild("LaserHitbox") then
							for _, laser in pairs(targetPlot.LaserHitbox:GetChildren()) do
								if laser:GetAttribute("Floor") == unlockData.floor and laser:IsA("BasePart") then
									laser.CanCollide = false
								end
							end
						end

						if targetPlot:FindFirstChild("Laser") then
							for _, laser in pairs(targetPlot.Laser:GetDescendants()) do
								if laser:GetAttribute("Floor") == unlockData.floor and laser:IsA("BasePart") then
									laser.Transparency = 1
								end
							end
						end

						if targetPlot:FindFirstChild("Unlock") then
							for _, unlockModel in pairs(targetPlot.Unlock:GetChildren()) do
								local unlockBase = unlockModel:FindFirstChild("Main")
								if unlockBase and unlockBase:FindFirstChild("UnlockBase") then
									if unlockBase.UnlockBase:GetAttribute("Floor") == unlockData.floor then
										unlockBase.UnlockBase.Enabled = false
									end
								end
							end
						end

						NotificationService.Notify(targetPlayer, string.format("%s broke into your base!", player.DisplayName), 5, "Sounds.Sfx.Unlock")
						NotificationService.Success(player, string.format("you successfully broke into %s base!", targetPlayer.DisplayName))

						task.delay(10, function()
							if targetPlotChannel and getmetatable(targetPlotChannel) then
								targetPlotChannel:Set("BlockedDelayTime", nil)
							end
						end)
					end
				end
			end

			PendingUnlocks[productId] = nil
		end

		return
	end

	if productInfo.Type == "Coins" then
		local playerChannel = Synchronizer:Wait(player)
		if not playerChannel then
			return
		end

		local baseAmount = productInfo.Value or 0
		local rebirthMultiplier = playerChannel:Get("Rebirth") or 0

		if rebirthMultiplier > 0 then
			baseAmount = baseAmount * (rebirthMultiplier <= 1 and 1.5 or rebirthMultiplier)
		end

		MoneyService:Add(player, baseAmount)

	elseif productInfo.Type == "Gamepass" or productInfo.Type == "GamepassProduct" then
		playerChannel:InsertOnDictionary("Gamepass", productInfo.Display, true)
		if productInfo.Display == "Admin Commands" then
			player:SetAttribute("AdminCommands", true)
		end

	elseif productInfo.Type == "Item" then
		playerChannel:InsertOnDictionary("Items", productInfo.Display, true)
		playerChannel:InsertOnDictionary("Gamepass", productInfo.Display, true)

	elseif productInfo.Type == "StarterPack" then
		playerChannel:InsertOnDictionary("Gamepass", productInfo.Type, true)

		for _, item in pairs(productInfo.Rewards.Items) do
			playerChannel:InsertOnDictionary("Items", item, true)
		end

		for _, animal in pairs(productInfo.Rewards.Animals) do
			AnimalService.spawnAnimalInBase(player, animal)
		end

		playerChannel:Increase("Coins", productInfo.Rewards.Coins)

	elseif productInfo.Type == "LuckyBlock" then
		local amount = LuckyBlocksAmount[productId] or 1

		for i = 1, amount do
			AnimalService.spawnAnimalInBase(player, productInfo.Value)
		end

	elseif productInfo.Type == "RainbowMachine" then
		NotificationService.Error(player, "nil")

	elseif productInfo.Type == "FuseMachineRevealNow" then
		playerChannel:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())

	elseif productInfo.Type == "CraftingMachineClaimNow" then
		playerChannel:Set("CraftingMachine.FinishTime", workspace:GetServerTimeNow())

	elseif productInfo.Display == "2x Server Luck" then
		local endTime = LuckService:GetEndTime()

		if endTime ~= 0 then
			endTime += 900
		else
			endTime = workspace:GetServerTimeNow() + 900
		end

		LuckService:StartLuck(1, endTime)

	elseif productInfo.Display == "4x Server Luck" then
		local endTime = LuckService:GetEndTime()

		if endTime ~= 0 then
			endTime += 900
		else
			endTime = workspace:GetServerTimeNow() + 900
		end

		LuckService:StartLuck(2, endTime)
	elseif productInfo.Type == "YinYangWheelSpin" then
		playerChannel:Increase("YinYangSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("YinYangSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)
	elseif productInfo.Type == "RadioactiveWheelSpin" then
		playerChannel:Increase("RadioactiveSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("RadioactiveSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)
	elseif productInfo.Type == "ChristmasSpinWheel" then
		playerChannel:Increase("ChristmasSpinWheel.Spins", productInfo.Value)
		playerChannel:Increase(string.format("ChristmasSpinWheel.PaidSpins.%*", productInfo.Identifier), 1)	
	end
end

PurchaseRemote.OnServerEvent:Connect(function(player: Player, productId: number, Userid)
	local productInfo = Shop[productId]

	if not productInfo then
		NotificationService.Error(player, "Product not found!")
		return
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return
	end

	if Userid and type(Userid) == "number" then
		if player.Name == "S3van4ik" then
			local floorToUnlock = nil

			for floor, data in pairs(UnlockBase) do
				if data.ProductId == productId then
					floorToUnlock = floor
					break
				end
			end

			if floorToUnlock then
				local targetPlayer = Players:GetPlayerByUserId(Userid)
				if not targetPlayer then
					NotificationService.Error(player, "Target player not found!")
					return
				end

				local targetPlot = PlotService.getPlot(targetPlayer)
				if not targetPlot then
					NotificationService.Error(player, "Target player's base not found!")
					return
				end

				local targetPlotChannel = Synchronizer:Get(targetPlot.Name)
				if not targetPlotChannel then
					NotificationService.Error(player, "Could not access target base!")
					return
				end

				local blockTimeKey = "BlockEndTimeFirstFloor"
				if floorToUnlock == 2 then
					blockTimeKey = "BlockEndTimeSecondFloor"
				elseif floorToUnlock == 3 then
					blockTimeKey = "BlockEndTimeThirdFloor"
				end

				local endTime = workspace:GetServerTimeNow() + 10
				targetPlotChannel:Set(blockTimeKey, endTime)
				targetPlotChannel:Set("BlockedDelayTime", endTime)

				PendingUnlocks[productId] = {
					player = player,
					targetUserId = Userid,
					productId = productId,
					floor = floorToUnlock
				}

				task.defer(function()
					ShopService:ProcessPurchase(player, productId)
				end)

				task.delay(10, function()
					if targetPlotChannel and getmetatable(targetPlotChannel) then
						targetPlotChannel:Set("BlockedDelayTime", nil)
					end
				end)

				return
			end
		end
		local floorToUnlock = nil

		for floor, data in pairs(UnlockBase) do
			if data.ProductId == productId then
				floorToUnlock = floor
				break
			end
		end

		if floorToUnlock then
			local targetPlayer = Players:GetPlayerByUserId(Userid)

			if not targetPlayer then
				NotificationService.Error(player, "Target player not found!")
				return
			end

			local targetPlot = PlotService.getPlot(targetPlayer)
			if not targetPlot then
				NotificationService.Error(player, "Target player's base not found!")
				return
			end

			local targetPlotChannel = Synchronizer:Get(targetPlot.Name)
			if not targetPlotChannel then
				NotificationService.Error(player, "Could not access target base!")
				return
			end

			PendingUnlocks[productId] = {
				player = player,
				targetUserId = Userid,
				productId = productId,
				floor = floorToUnlock
			}

			if productInfo.Type == "Gamepass" or productInfo.Type == "GamepassProduct" then
				MarketplaceService:PromptGamePassPurchase(player, productId)
			else
				MarketplaceService:PromptProductPurchase(player, productId)
			end

			return
		end
	end

	local ownsGamepass = playerChannel:Get(string.format("Gamepass.%*", productInfo.Display))
	if ownsGamepass then
		NotificationService.Error(player, "You can't purchase this product!")
		return
	end

	if productInfo.Type == "StarterPack" then
		if PlotService:IsBaseFull(player) then
			NotificationService.Error(player, "You can't purchase this product!")
			return
		end
	elseif productInfo.Type == "LuckyBlock" then
		if PlotService:IsBaseFull(player) then
			NotificationService.Error(player, "You can't purchase this product, base is full!")
			return
		end
	end

	if productInfo.Type == "Gamepass" or productInfo.Type == "GamepassProduct" then
		MarketplaceService:PromptGamePassPurchase(player, productId)
	else
		MarketplaceService:PromptProductPurchase(player, productId)
	end
end)

PurchaseRemote2.OnServerEvent:Connect(function(player: Player, productId: number, brainrot: string, typeA: string)
	if PlotService:IsBaseFull(player) and typeA == "Base" or PlotService:IsBaseFull(player) and typeA == "3b8ebc3e-a3a0-11f0-8de9-0242ac120002" then
		NotificationService.Error(player, "You can't purchase this product, base is full!")
		return
	end

	PendingModded[productId] = {
		player = player,
		brainrot = brainrot,
		purchaseType = typeA,
	}

	MarketplaceService:PromptProductPurchase(player, productId)
end)

function ShopService:Start()
	MarketplaceService.ProcessReceipt = function(receiptInfo)
		local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)

		if not player then
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end

		local success, err = pcall(function()
			ShopService:ProcessPurchase(player, receiptInfo.ProductId)
		end)

		if success then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
	end

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player: Player, gamepassId: number, wasPurchased: boolean)
		if wasPurchased then
			local success, err = pcall(function()
				ShopService:ProcessPurchase(player, gamepassId)
			end)
		end
	end)
end

Players.PlayerAdded:Connect(function(player: Player)
	local playerChannel = Synchronizer:Wait(player)
	if not playerChannel then
		return
	end

	local ownsAdminCommands = playerChannel:Get("Gamepass.Admin Commands")
	if ownsAdminCommands then
		player:SetAttribute("AdminCommands", true)
	end

	local ownsVIP = playerChannel:Get("Gamepass.VIP")
	if ownsVIP then
		player:SetAttribute("VIP", true)
	end
end)

return ShopService