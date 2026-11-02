local AnimalService = require(game.ServerScriptService.Services.AnimalService)

local module = function(Conch, Config)
	Conch.register("maxluck", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "state",
			}
		end,
		callback = function(state)
			if state == "On" or state == "on" then
				AnimalService.MaxLuck = true
				return "enabled"
			end
			if state == "Off" or state == "off" then
				AnimalService.MaxLuck = false
				return "disabled"
			end
			if state ~= "Off" or state ~= "off" or state ~= "On" or state ~= "on" then
				return "Use only On or Off"
			end
		end,
	})
end

return module