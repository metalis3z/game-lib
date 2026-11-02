local module = function(Conch, Config)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local MessagingService = game:GetService("MessagingService")
	local ServerScriptService = game:GetService("ServerScriptService")

	local function skipRollForAllPlayers()
		local RollMachineService = require(ServerScriptService.Services.RollMachineService)
		RollMachineService:SkipCooldownForAllPlayers()
	end

	MessagingService:SubscribeAsync("GlobalRollSkip", function(message)
		local data = message.Data
		if not data then return end
		if data.FromServer == game.JobId then return end

		if data.Skip then
			skipRollForAllPlayers()
		end
	end)

	Conch.register("globalrollskip", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return nil
		end,

		callback = function(context)
			skipRollForAllPlayers()

			pcall(function()
				MessagingService:PublishAsync("GlobalRollSkip", {
					FromServer = game.JobId,
					Skip = true
				})
			end)

			return "skipped"
		end,
	})
end

return module