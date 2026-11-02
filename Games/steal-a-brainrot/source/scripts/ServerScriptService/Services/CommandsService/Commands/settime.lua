local module = function(Conch, Config)
	Conch.register("settime", {
		permissions = { Config.RequiredRole or "limited-commands" },
		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "amount",
			}
		end,

		callback = function(amount)
			if amount == nil then
				return "amount must not be nil!"
			end

			local Lighting = game:GetService("Lighting")
			Lighting.TimeOfDay = amount


			return "set"
		end,
	})
end

return module