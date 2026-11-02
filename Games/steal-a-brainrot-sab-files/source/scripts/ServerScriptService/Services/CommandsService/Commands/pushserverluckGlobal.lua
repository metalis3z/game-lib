local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local GLOBAL_LUCK_TOPIC = "GlobalServerLuckUpdate"

MessagingService:SubscribeAsync(GLOBAL_LUCK_TOPIC, function(message)
	local data = message.Data
	if not data then return end

	if data.type == "ServerLuckUpdate" then
		local LuckService = require(ServerScriptService.Services.LuckService)
		LuckService:SetLuck(data.luck)
	end
end)

local module = function(Conch, Config)
	Conch.register("pushserverluckGlobal", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Luck"
			}
		end,

		callback = function(luckValue, context)
			local luck = tonumber(luckValue)
			if not luck then
				return false, "Must be a number."
			end

			local executorName = context and context.Executor and context.Executor.Name or "Server"

			local LuckService = require(ServerScriptService.Services.LuckService)
			LuckService:SetLuck(luck)

			pcall(function()
				MessagingService:PublishAsync(GLOBAL_LUCK_TOPIC, {
					type = "ServerLuckUpdate",
					luck = luck,
					executor = executorName
				})
			end)

			local gradientTag = "rainbow"
			local msg = "Admin Activated " .. string.format("<%s>%sX Luck!</%s>", gradientTag, luck, gradientTag)

			for _, player in ipairs(Players:GetPlayers()) do
				pcall(function()
					NotificationEvent:FireClient(player, msg, 5, "Sounds.Sfx.Success")
				end)
			end

			return string.format("Server luck set to %dX", luck)
		end
	})
end

return module