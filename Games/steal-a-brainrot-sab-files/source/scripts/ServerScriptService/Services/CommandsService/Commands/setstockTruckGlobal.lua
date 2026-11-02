local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local DataStoreService = game:GetService("DataStoreService")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local GLOBAL_TRUCK_TOPIC = "GlobalTruckStockUpdate"
local GLOBAL_NOTIFY_TOPIC = "GlobalTruckNotify"
local Stock_Key = "StockEvent_La_Romantic_Grande"
local StockStore = DataStoreService:GetDataStore("StockValentines")

MessagingService:SubscribeAsync(GLOBAL_TRUCK_TOPIC, function(message)
	local data = message.Data
	if not data then return end

	if data.type == "TruckStockUpdate" then
		ReplicatedStorage:SetAttribute(Stock_Key, data.amount)

		local stockModel = workspace:FindFirstChild("Events") and 
			workspace.Events:FindFirstChild("Stock") and 
			workspace.Events.Stock:FindFirstChild("Model")

		if stockModel then
			local countdown = stockModel:FindFirstChild("Overhead") and
				stockModel.Overhead:FindFirstChild("BillboardGui") and
				stockModel.Overhead.BillboardGui:FindFirstChild("Countdown")

			if countdown then
				if data.amount <= 0 then
					countdown.Text = "SOLD OUT"
					countdown.TextColor3 = Color3.fromRGB(255, 0, 0)
				else
					local formatted = tostring(data.amount)
					local k
					while true do
						formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')
						if k == 0 then break end
					end
					countdown.Text = formatted .. " Left"
					countdown.TextColor3 = Color3.fromRGB(255, 255, 255)
				end
			end
		end

		task.spawn(function()
			pcall(function()
				StockStore:SetAsync(Stock_Key, data.amount)
			end)
		end)
	end
end)

MessagingService:SubscribeAsync(GLOBAL_NOTIFY_TOPIC, function(message)
	local data = message.Data
	if not data then return end

	if data.type == "TruckNotify" then
		for _, plr in ipairs(Players:GetPlayers()) do
			pcall(function()
				NotificationEvent:FireClient(plr, data.msg, 5, "Sounds.Sfx.Success")
			end)
		end
	end
end)

local module = function(Conch, Config)

	local function formatNumber(num)
		local formatted = tostring(num)
		local k
		while true do
			formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')
			if k == 0 then break end
		end
		return formatted
	end

	Conch.register("setstockTruckGlobal", {
		permissions = { Config.RequiredRole or "CustomAdmin" },

		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Amount"
			}
		end,

		callback = function(amount, context)
			amount = tonumber(amount)
			if not amount then
				return false, "only numbers."
			end
			if amount < 0 then
				return false, "Amount cant be negative."
			end
			if amount > 10000000 then
				return false, "its too much, max is 10000000."
			end

			local executorName = context and context.Executor and context.Executor.Name or "Server"

			ReplicatedStorage:SetAttribute(Stock_Key, amount)

			pcall(function()
				MessagingService:PublishAsync(GLOBAL_TRUCK_TOPIC, {
					type = "TruckStockUpdate",
					amount = amount,
					executor = executorName
				})
			end)

			local stockModel = workspace:FindFirstChild("Events") and 
				workspace.Events:FindFirstChild("Stock") and 
				workspace.Events.Stock:FindFirstChild("Model")

			if stockModel then
				local countdown = stockModel:FindFirstChild("Overhead") and
					stockModel.Overhead:FindFirstChild("BillboardGui") and
					stockModel.Overhead.BillboardGui:FindFirstChild("Countdown")

				if countdown then
					if amount <= 0 then
						countdown.Text = "SOLD OUT"
						countdown.TextColor3 = Color3.fromRGB(255, 0, 0)
					else
						local formatted = formatNumber(amount)
						countdown.Text = formatted .. " Left"
						countdown.TextColor3 = Color3.fromRGB(255, 255, 255)
					end
				end
			end

			pcall(function()
				StockStore:SetAsync(Stock_Key, amount)
			end)

			local msg = string.format(
				"<font color='#FF0000'>Nova</font> Set Los Meal Combinasion stock to <font color='#FF0000'>%s</font>",
				formatNumber(amount)
			)

			pcall(function()
				MessagingService:PublishAsync(GLOBAL_NOTIFY_TOPIC, {
					type = "TruckNotify",
					msg = msg
				})
			end)

			return string.format("fayple set Los Meal Combinasion to %d", amount)
		end
	})

	Conch.register("checkstockTruck", {
		permissions = { Config.RequiredRole or "Admin" },

		arguments = function()
			return {}
		end,

		callback = function()
			local currentStock = ReplicatedStorage:GetAttribute(Stock_Key) or 0
			return string.format("Current stock for La Taco Combinasion: %s", formatNumber(currentStock))
		end
	})

	Conch.register("addstockTruckGlobal", {
		permissions = { Config.RequiredRole or "CustomAdmin" },

		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Amount"
			}
		end,

		callback = function(amount, context)
			amount = tonumber(amount)
			if not amount then
				return false, "put there a number"
			end
			if amount <= 0 then
				return false, "amount must be positive"
			end

			local executorName = context and context.Executor and context.Executor.Name or "Server"
			local currentStock = ReplicatedStorage:GetAttribute(Stock_Key) or 0
			local newStock = currentStock + amount

			ReplicatedStorage:SetAttribute(Stock_Key, newStock)

			pcall(function()
				MessagingService:PublishAsync(GLOBAL_TRUCK_TOPIC, {
					type = "TruckStockUpdate",
					amount = newStock,
					executor = executorName
				})
			end)

			local stockModel = workspace:FindFirstChild("Events") and 
				workspace.Events:FindFirstChild("Stock") and 
				workspace.Events.Stock:FindFirstChild("Model")

			if stockModel then
				local countdown = stockModel:FindFirstChild("Overhead") and
					stockModel.Overhead:FindFirstChild("BillboardGui") and
					stockModel.Overhead.BillboardGui:FindFirstChild("Countdown")

				if countdown then
					if newStock <= 0 then
						countdown.Text = "SOLD OUT"
						countdown.TextColor3 = Color3.fromRGB(255, 0, 0)
					else
						local formatted = formatNumber(newStock)
						countdown.Text = formatted .. " Left"
						countdown.TextColor3 = Color3.fromRGB(255, 255, 255)
					end
				end
			end

			pcall(function()
				StockStore:SetAsync(Stock_Key, newStock)
			end)

			local msg = string.format(
				"<font color='#FF0000'>Admin</font> added %s stock (now: <font color='#FF0000'>%s</font>)",
				formatNumber(amount),
				formatNumber(newStock)
			)

			pcall(function()
				MessagingService:PublishAsync(GLOBAL_NOTIFY_TOPIC, {
					type = "TruckNotify",
					msg = msg
				})
			end)

			return string.format("Admin added %d stock (now: %d)", amount, newStock)
		end
	})
end

return module