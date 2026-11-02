local SS = game:GetService("ServerScriptService")
local CountdownService = require(SS:WaitForChild("Services"):FindFirstChild("CountdownService"))

local module = function(Conch, Config)
	Conch.register("startcountdown", {
		permissions = { Config.RequiredRole or "limited-commands" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "string",
					name = "text",
				},
				{
					kind = "argument",
					type = "number",
					name = "Hours",
				},
				{
					kind = "argument",
					type = "number",
					name = "Minutes",
				},
				{
					kind = "argument",
					type = "number",
					name = "Seconds",
				}
		end,

		callback = function(text, hours, minutes, seconds)
			hours = hours or 0
			minutes = minutes or 0
			seconds = seconds or 0

			local totalSeconds = math.floor(hours) * 3600 + math.floor(minutes) * 60 + math.floor(seconds)

			if totalSeconds <= 0 then
				return false, "Tu dois fournir un temps valide! (ex: 0 30 0 = 30 minutes)"
			end

			return CountdownService.startCountdown(text, totalSeconds)
		end,
	})
end

return module