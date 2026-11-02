local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MessagingService = game:GetService("MessagingService")

local FatSammy = require(ServerScriptService.Services.EventService.Events.FatSammy)
local Net = require(ReplicatedStorage.Packages.Net)

local module = function(Conch, Config)
	Conch.register("FinishEatSammy", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function() return end,
		callback = function()
			MessagingService:PublishAsync("Global_FinishEatSammy", {})
			return "executed"
		end,
	})

	MessagingService:SubscribeAsync("Global_FinishEatSammy", function()
		FatSammy:AutoEat()
	end)
end

return module
