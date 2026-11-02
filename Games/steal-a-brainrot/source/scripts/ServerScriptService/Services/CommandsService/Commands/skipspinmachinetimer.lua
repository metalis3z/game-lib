local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local SpinMachineService = require(ServerScriptService.Services.SpinMachineService)

	Conch.register("skipspinmachinetimer", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
		end,

		callback = function()
			SpinMachineService.SkipAllTimers()
			return "All Spin Machine timers have been skipped globally for all players."
		end
	})
end

return module