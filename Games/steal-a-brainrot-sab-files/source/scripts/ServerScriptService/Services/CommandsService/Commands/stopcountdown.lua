local SS = game:GetService("ServerScriptService")
local CountdownService = require(SS:WaitForChild("Services"):FindFirstChild("CountdownService"))

local module = function(Conch, Config)
	Conch.register("stopcountdown", {
		permissions = { Config.RequiredRole or "limited-commands" },
		arguments = function()
			return
		end,

		callback = function()
			return CountdownService.stopCountdown()
		end,
	})
end

return module