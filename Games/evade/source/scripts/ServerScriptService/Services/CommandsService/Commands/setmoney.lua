local module = function(Conch, Config)
	Conch.register("setmoney", {
		permissions = { Config.RequiredRole or "set-money" },
		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Amount",
			}
		end,

		callback = function(amount)
			if amount == nil then
				return "amount must not be nil!"
			end

			local ctx = Conch.get_command_context()
			local player = ctx and ctx.executor and ctx.executor.player

			local DataManagement = require(game.ServerScriptService.Services.MoneyService)
			local Synchronizer = require(game.ReplicatedStorage.Packages.Synchronizer)

			DataManagement:Set(player, amount)

			task.wait(0.1)

			local playerSync = Synchronizer:Get(player)
			if playerSync then
				playerSync:Set("Coins", amount)
			end

			return "set"
		end,
	})
end

return module