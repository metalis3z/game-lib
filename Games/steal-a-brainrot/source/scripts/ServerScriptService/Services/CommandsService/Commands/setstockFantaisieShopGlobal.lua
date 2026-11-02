local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local GLOBAL_ASTRO_TOPIC = "GlobalFantaisieShopStockUpdate"

MessagingService:SubscribeAsync(GLOBAL_ASTRO_TOPIC, function(message)
	local data = message.Data
	if not data then return end
	if data.Type == "StockUpdate" then
		ReplicatedStorage:SetAttribute(data.Attribute, data.Amount)
	end
end)

local module = function(Conch, Config)
	local FantaisieShopData = require(ReplicatedStorage.Datas.FantaisieShopData)

	local function halfHour(now)
		now = now or Workspace:GetServerTimeNow()
		local dt = DateTime.fromUnixTimestamp(now)
		local m = tonumber(dt:FormatUniversalTime("mm", "en-us")) or 0
		return (m < 30) and "00" or "30"
	end

	local function getAttrName(stockKey, now)
		now = now or Workspace:GetServerTimeNow()
		local dt = DateTime.fromUnixTimestamp(now)
		local Y = dt:FormatUniversalTime("YYYY", "en-us")
		local M = dt:FormatUniversalTime("MM", "en-us")
		local D = dt:FormatUniversalTime("DD", "en-us")
		local H = dt:FormatUniversalTime("HH", "en-us")
		local mm = halfHour(now)

		local keyString = string.format("%s-%s%s%s-%s%s", stockKey, Y, M, D, H, mm)
		return "AstroStock_" .. (keyString:gsub("%s", "_"))
	end

	local function findBrainrot(searchTerm)
		searchTerm = string.lower(searchTerm)

		for _, itemData in ipairs(FantaisieShopData.Brainrots) do
			if itemData and itemData.Brainrot then
				if string.lower(itemData.Brainrot) == searchTerm then
					return itemData
				end
			end
		end

		for _, itemData in ipairs(FantaisieShopData.Brainrots) do
			if itemData and itemData.StockKey then
				if string.lower(itemData.StockKey) == searchTerm then
					return itemData
				end
			end
		end
		return nil
	end

	Conch.register("setstockFantaisieShopGlobal", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "BrainrotName"
			}, {
				kind = "argument",
				type = "number",
				name = "Amount"
			}
		end,
		callback = function(searchTerm, amount, context)
			if type(amount) ~= "number" or amount < 0 then
				return false, "Amount must be a positive number."
			end

			local foundItem = findBrainrot(searchTerm)
			if not foundItem then
				return false, string.format("Brainrot '%s' not found in Fantaisie Shop.", searchTerm)
			end

			local attrName = getAttrName(foundItem.StockKey)
			local executorName = context and context.Executor and context.Executor.Name or "Server"

			ReplicatedStorage:SetAttribute(attrName, amount)

			pcall(function()
				MessagingService:PublishAsync(GLOBAL_ASTRO_TOPIC, {
					Type = "StockUpdate",
					Attribute = attrName,
				Amount = amount,
					Brainrot = foundItem.Brainrot,
					Executor = executorName,
					Timestamp = Workspace:GetServerTimeNow()
				})
			end)

			for _, player in pairs(Players:GetPlayers()) do
				NotificationEvent:FireClient(
					player,
					string.format(
						"<font color='#9b59b6'>Fantaisie Shop</font> <font color='#ffffff'>%s</font> has been restocked to %d",
						foundItem.Brainrot,
						amount
					),
					6,
					"Sounds.Sfx.Success"
				)
			end

			return string.format("%s has been restocked to %d", foundItem.Brainrot, amount)
		end,
	})
end

return module