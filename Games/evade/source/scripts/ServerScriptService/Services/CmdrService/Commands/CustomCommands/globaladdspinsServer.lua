local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")

local Net = require(ReplicatedStorage.Packages.Net)
local GlobalAddSpins = Net:RemoteEvent("AdminService/GlobalAddSpins")

local isProcessing = false

local function applySpinsToPlayers(amount, adminName)
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local NotificationService = require(ServerScriptService.Services.NotificationService)

	for _, player in pairs(game.Players:GetPlayers()) do
		local playerChannel = Synchronizer:Get(player)
		if playerChannel then
			playerChannel:Increase("RadioactiveSpinWheel.Spins", amount)
			NotificationService.Notify(
				player,
				context.Executor.Name .. ' got a <font color="#68f500">' .. amount .. '</font> free spin(s) in the <font color="#68f500">Radioactive</font> Event!',
				10,
				"Sounds.Sfx.Success"
			)
		end
	end
end

-- Subscribe only once when module loads
pcall(function()
	MessagingService:SubscribeAsync("GlobalAddSpins", function(message)
		-- Fixed: Use message.Data.JobId instead of FromServer
		if isProcessing or message.Data.JobId == game.JobId then 
			return 
		end
		local amount = message.Data.Amount
		local adminName = message.Data.Admin
		applySpinsToPlayers(amount, adminName)
	end)
end)

return function(context, amount)
	if isProcessing or not amount or amount <= 0 then
		return "❌ Amount must be a positive number!"
	end

	isProcessing = true

	-- BROADCAST TO ALL SERVERS with JobId
	local publishSuccess, publishError = pcall(function()
		MessagingService:PublishAsync("GlobalAddSpins", {
			Amount = amount,
			Admin = context.Executor.Name,
			JobId = game.JobId  -- Fixed: Use JobId consistently
		})
	end)

	-- ADD TO THIS SERVER IMMEDIATELY (safe because subscribe checks JobId)
	applySpinsToPlayers(amount, context.Executor.Name)

	isProcessing = false

	if publishSuccess then
		return string.format("✅ Added %d spins to ALL PLAYERS across ALL SERVERS!", amount)
	else
		return string.format("⚠️ Added %d spins locally but failed to broadcast globally: %s", amount, tostring(publishError))
	end
end