local Module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local CodeService = require(ServerScriptService.Services.CodeService)

	Conch.register("generatelimitedcode", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "number",
					name = "Stock",
				},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot",
			},
			{
				kind = "argument",
				type = "string",
				name = "Code",
			}
		end,

		callback = function(stock, brainrot, code)
			local quantity = tonumber(stock)
			if not quantity then
				return false, "Stock must be a number."
			end

			quantity = math.floor(quantity)
			if quantity <= 0 then
				return false, "Stock must be higher than 0."
			end

			local success, message = CodeService.GenerateLimitedBrainrotCode(code, brainrot, quantity)
			if not success then
				return false, message
			end

			return message
		end,
	})
end
-- FAYPLESTUDIOS DISCORD SERVER : https://discord.gg/QbuKJmAYK
return Module