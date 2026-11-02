--Fayple Studios Script , 12.03.26 , do not steal 
local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local GLOBAL_STOCK_TOPIC = "GlobalMerchantStockUpdate"
local GLOBAL_COMMAND_TOPIC = "GlobalMerchantCommand"
MessagingService:SubscribeAsync(GLOBAL_STOCK_TOPIC, function(message)
	local data = message.Data
	if not data then return end
	if data.type == "GlobalStockUpdate" then
		local update = data.update
		if not update then return end
		ReplicatedStorage:SetAttribute(update.name, update.amount)
	end
end)
MessagingService:SubscribeAsync(GLOBAL_COMMAND_TOPIC, function(message)
	local data = message.Data
	if not data then return end

	if data.type == "SetStock" then
		ReplicatedStorage:SetAttribute(data.attribute, data.amount)

		for _, player in pairs(Players:GetPlayers()) do
			NotificationEvent:FireClient(
				player,
				string.format(
					"<font color='#FF0000'>%s</font> has been restocked to %d",
					data.brainrotName,
					data.amount
				),
				6,
				"Sounds.Sfx.Success"
			)
		end
	end
end)
local module = function(Conch, Config)
	local MerchantData = require(ReplicatedStorage.Datas.MerchantData)

	local function halfHour(now)
		now = now or Workspace:GetServerTimeNow()
		local dt = DateTime.fromUnixTimestamp(now)
		local m = tonumber(dt:FormatUniversalTime("mm","en-us")) or 0
		return (m < 30) and "00" or "30"
	end

	local function getAttrName(stockKey, now)
		now = now or Workspace:GetServerTimeNow()
		local dt = DateTime.fromUnixTimestamp(now)
		local Y = dt:FormatUniversalTime("YYYY","en-us")
		local M = dt:FormatUniversalTime("MM","en-us")
		local D = dt:FormatUniversalTime("DD","en-us")
		local H = dt:FormatUniversalTime("HH","en-us")
		local mm = halfHour(now)

		local keyString = string.format("%s-%s%s%s-%s%s", stockKey, Y, M, D, H, mm)
		return "StockEvent_" .. (keyString:gsub("%s", "_")), keyString
	end

	local function findBrainrot(searchTerm)
		searchTerm = string.lower(searchTerm)

		for _, itemData in ipairs(MerchantData.Brainrots) do
			if itemData and itemData.Brainrot then
				if string.lower(itemData.Brainrot) == searchTerm then
					return itemData
				end
			end
		end

		for _, itemData in ipairs(MerchantData.Brainrots) do
			if itemData and itemData.StockKey then
				if string.lower(itemData.StockKey) == searchTerm then
					return itemData
				end
			end
		end
		return nil
	end
	Conch.register("setstockBrainrotShopGlobal", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "BrainrotName"
			},
			{
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
				return false, string.format("Brainrot '%s' not found.", searchTerm)
			end
			local attrName = getAttrName(foundItem.StockKey)
			local executorName = context and context.Executor and context.Executor.Name or "Server"
			ReplicatedStorage:SetAttribute(attrName, amount)
			pcall(function()
				MessagingService:PublishAsync(GLOBAL_COMMAND_TOPIC, {
					type = "SetStock",
					attribute = attrName,
					amount = amount,
					brainrotName = foundItem.Brainrot,
					executor = executorName
				})
			end)
			local merchant = Workspace:FindFirstChild("Merchant")
			if merchant then
				local rig = merchant:FindFirstChild("Rig")
				local playEvent = rig and rig:FindFirstChild("Play")
				if playEvent and playEvent:IsA("BindableEvent") then
					playEvent:Fire(1)
				end
			end
			return string.format("<font color='#FF0000'>%s</font> has been restocked to %d", foundItem.Brainrot, amount)
		end
	})
end

return module