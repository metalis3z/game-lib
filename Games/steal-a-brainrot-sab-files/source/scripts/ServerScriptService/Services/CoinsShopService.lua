--!strict

local CoinsShopService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local MoneyService = require(ServerScriptService.Services.MoneyService)
local Net = require(ReplicatedStorage.Packages.Net)
local ShopItems = require(ReplicatedStorage.Datas.ShopItems)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local RequestBuy = Net:RemoteFunction("CoinsShopService/RequestBuy")
local ToggleAutoBuy = Net:RemoteFunction("CoinsShopService/ToggleAutoBuy")

local TrapCounts: { [Player]: number } = {}
local CakeTrapCounts: { [Player]: number } = {}
local LastPurchaseTime: { [Player]: number } = {}

local PURCHASE_COOLDOWN = 0.5

function CoinsShopService:Start()
	task.spawn(function()
		Players.PlayerAdded:Connect(function(player)
			TrapCounts[player] = 0
			CakeTrapCounts[player] = 0
			LastPurchaseTime[player] = 0
			player:SetAttribute("TrapCount", nil)
		end)

		Players.PlayerRemoving:Connect(function(player)
			TrapCounts[player] = nil
			CakeTrapCounts[player] = nil
			LastPurchaseTime[player] = nil
		end)

		local function isOnCooldown(player: Player): (boolean, string?)
			local now = os.clock()
			if LastPurchaseTime[player] and now - LastPurchaseTime[player] < PURCHASE_COOLDOWN then
				return true, "Hold on! You need to wait a bit before doing that again."
			end
			LastPurchaseTime[player] = now
			return false
		end

		RequestBuy.OnServerInvoke = function(player: Player, item: string): (boolean, string)
			assert(item)

			local onCooldown, cooldownMessage = isOnCooldown(player)
			if onCooldown then
				return false, cooldownMessage
			end

			local playerChannel = Synchronizer:Get(player)
			assert(playerChannel)

			local productInfo = ShopItems[item]
			assert(productInfo)

			local requiredRebirths = productInfo.RebirthRequired or 0
			local playerRebirths = playerChannel:Get("Rebirth") or 0
			if playerRebirths < requiredRebirths then
				return false, string.format("Purchase failed! You don't have the required Rebirth to buy %s.", item)
			end

			if not MoneyService:CanAfford(player, productInfo.Price) then
				return false, string.format("Purchase failed! You don't have enough Coins to buy %s.", item)
			end

			if item == "Trap" then
				local currentCount = TrapCounts[player] or 0
				if currentCount >= 5 then
					return false, "Purchase failed!"
				end
				MoneyService:Add(player, -productInfo.Price)
				local newCount = currentCount + 1
				TrapCounts[player] = newCount
				player:SetAttribute("TrapCount", newCount)
				playerChannel:InsertOnDictionary("SessionTraps", tostring(newCount), true)
				playerChannel:InsertOnDictionary("Items", item, true)

			elseif item == "Cake Trap" then
				local currentCount = CakeTrapCounts[player] or 0
				if currentCount >= 5 then
					return false, "Purchase failed! You can only own up to 5 Cake Traps."
				end
				MoneyService:Add(player, -productInfo.Price)
				CakeTrapCounts[player] = currentCount + 1

			else
				if playerChannel:Get(string.format("Items.%s", item)) then
					return false, string.format("Purchase failed! You already own %s.", item)
				end
				MoneyService:Add(player, -productInfo.Price)
				playerChannel:InsertOnDictionary("Items", item, true)
			end

			return true, string.format("Purchase successful! You bought %s.", item)
		end

		ToggleAutoBuy.OnServerInvoke = function(player: Player, item: string): (boolean, string?)
			assert(item)

			local onCooldown, cooldownMessage = isOnCooldown(player)
			if onCooldown then
				return false, cooldownMessage
			end

			local playerChannel = Synchronizer:Get(player)
			assert(playerChannel)

			local productInfo = ShopItems[item]
			assert(productInfo)

			local requiredRebirths = productInfo.RebirthRequired or 0
			local playerRebirths = playerChannel:Get("Rebirth") or 0
			if playerRebirths < requiredRebirths then
				return false, string.format("Purchase failed! You don't have the required Rebirth to buy %s.", item)
			end

			local path = string.format("AutoBuy.%s", item)
			local currentValue: boolean? = playerChannel:Get(path)
			local newValue: boolean = not currentValue

			playerChannel:Set(path, newValue)

			return true, string.format("Purchase successful! You bought %s.", item)
		end
	end)
end

return CoinsShopService
