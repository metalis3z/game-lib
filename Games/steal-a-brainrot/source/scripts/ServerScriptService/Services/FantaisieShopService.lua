local FantaisieShopService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local MessagingService = game:GetService("MessagingService")
local Net = require(ReplicatedStorage.Packages.Net)
local FantaisieShopData = require(ReplicatedStorage.Datas.FantaisieShopData)
local MoneyService = require(script.Parent.Parent.Services.MoneyService)
local AnimalService = require(script.Parent.Parent.Services.AnimalService)
local Animals = require(ReplicatedStorage.Datas.Animals)
local PlotService = require(script.Parent.Parent.Services.PlotService)
local SetFocused = Net:RemoteEvent("FantaisieShopService/SetFocused")
local Animation = Net:RemoteEvent("FantaisieShopService/Animation")
local Buy = Net:RemoteFunction("FantaisieShopService/Buy")
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local AstroNextAttr = "FantaisieShopNextRestockEpoch"
local GLOBAL_STOCK_TOPIC = "GlobalFantaisieShopStockUpdate"
local initialized = false
local locks = {}
local Cooldowns = {}
local PURCHASE_COOLDOWN = 5

local function halfHour(now)
	now = now or Workspace:GetServerTimeNow()
	local dt = DateTime.fromUnixTimestamp(now)
	local m = tonumber(dt:FormatUniversalTime("mm","en-us")) or 0
	return (m < 30) and "00" or "30"
end

local function getNextHalfHourTime(now)
	now = now or Workspace:GetServerTimeNow()
	local secondsIntoHalfHour = now % 1800
	if secondsIntoHalfHour == 0 then
		return now + 1800
	end
	return now + (1800 - secondsIntoHalfHour)
end

local function attrNameFor(entry, now)
	now = now or Workspace:GetServerTimeNow()
	local dt = DateTime.fromUnixTimestamp(now)
	local Y = dt:FormatUniversalTime("YYYY","en-us")
	local M = dt:FormatUniversalTime("MM","en-us")
	local D = dt:FormatUniversalTime("DD","en-us")
	local H = dt:FormatUniversalTime("HH","en-us")
	local mm = halfHour(now)
	local key = string.format("%s-%s%s%s-%s%s", entry.StockKey, Y, M, D, H, mm)
	return "AstroStock_" .. (key:gsub("%s","_"))
end

local function publishGlobalStockUpdate(attrName, newAmount, brainrotName, executor)
	local success, result = pcall(function()
		MessagingService:PublishAsync(GLOBAL_STOCK_TOPIC, {
			Type = "StockUpdate",
			Attribute = attrName,
			Amount = newAmount,
			Brainrot = brainrotName,
			Executor = executor or "System",
			Timestamp = Workspace:GetServerTimeNow()
		})
	end)
	if not success then
		warn("[FantaisieShopService] Failed to publish global stock update:", result)
	end
end

local function subscribeToGlobalUpdates()
	pcall(function()
		MessagingService:SubscribeAsync(GLOBAL_STOCK_TOPIC, function(message)
			local data = message.Data
			if data and data.Type == "StockUpdate" then
				ReplicatedStorage:SetAttribute(data.Attribute, data.Amount)
			end
		end)
	end)
end

local function setAllStockZero()
	for _, entry in ipairs(FantaisieShopData.Brainrots) do
		if entry and entry.StockKey and entry.Brainrot then
			local attrName = attrNameFor(entry)
			ReplicatedStorage:SetAttribute(attrName, 0)
		end
	end
end

local function withLock(key, fn)
	while locks[key] do task.wait() end
	locks[key] = true
	local ok, results = pcall(fn)
	locks[key] = nil
	if not ok then
		return false, tostring(results)
	end
	return true, results
end

local function ensureInit()
	if initialized then return end
	initialized = true
	subscribeToGlobalUpdates()
	setAllStockZero()

	Buy.OnServerInvoke = function(player, _, index)
		local ts = Workspace:GetServerTimeNow()
		local last = Cooldowns[player.UserId]
		if last and ts - last < PURCHASE_COOLDOWN then
			NotificationEvent:FireClient(player, "<font color='#EC2321'>Please wait a few seconds before buying another brainrot</font>", 2, "Sounds.Sfx.Error")
			return false
		end
		local entry = FantaisieShopData.Brainrots[index]
		if not entry then
			warn("[FantaisieShopService] No entry found for index:", index)
			return false
		end
		local animal = Animals[entry.Brainrot]
		if not animal then
			warn("[FantaisieShopService] No animal found for brainrot:", entry.Brainrot)
			return false
		end
		local price = animal.Price or 0
		if not MoneyService:CanAfford(player, price) then
			warn("[FantaisieShopService] Player cannot afford:", price)
			return false
		end
		local attrName = attrNameFor(entry)
		local success, result = withLock(attrName, function()
			local currentStock = ReplicatedStorage:GetAttribute(attrName)
			if type(currentStock) ~= "number" or currentStock <= 0 then
				return nil, "Sold out"
			end
			local newStock = currentStock - 1
			ReplicatedStorage:SetAttribute(attrName, newStock)
			publishGlobalStockUpdate(attrName, newStock, entry.Brainrot, player.Name)
			return newStock
		end)

		if not success or not result then
			warn("[FantaisieShopService] Purchase failed - success:", success, "result:", result)
			return false
		end
		MoneyService:Add(player, -price)
		Animation:FireAllClients(nil, animal.Rarity)
		local plot = PlotService.getPlot(player)
		if plot then
			AnimalService.spawnAnimalCustom(animal, nil, nil, nil, {
				Start = workspace.FantaisieShop and workspace.FantaisieShop.Prompt or nil,
				End = plot.AnimalTarget,
				Owner = player
			})
		end
		Cooldowns[player.UserId] = ts
		return true
	end
end

function FantaisieShopService.Start()
	task.spawn(ensureInit)
end

return FantaisieShopService