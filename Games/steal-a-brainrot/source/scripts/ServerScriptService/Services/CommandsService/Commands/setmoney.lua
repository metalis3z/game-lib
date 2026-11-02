local module = function(Conch, Config)
	Conch.register("setmoney", {
		permissions = { Config.RequiredRole or "limited-commands" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "number",
				name = "Amount",
			}
		end,

		callback = function(targetPlayer, amount)
			if not targetPlayer then
				return "player not found"
			end

			if amount == nil then
				return "amount must not be nil"
			end

			local MoneyService = require(game.ServerScriptService.Services.MoneyService)

			MoneyService:Set(targetPlayer, amount)

			return "set"
		end
	})
end

return module