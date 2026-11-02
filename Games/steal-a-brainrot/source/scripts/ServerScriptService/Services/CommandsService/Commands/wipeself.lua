local module = function(Conch, Config)
	Conch.register("wipeself", {
		permissions = { Config.RequiredRole or "limited-commands" },
		arguments = function()
			return
		end,

		callback = function()
			local ctx = Conch.get_command_context()
			local player = ctx and ctx.executor and ctx.executor.player

			local DataManagement = require(game.ServerScriptService.Services.DataService)

			DataManagement:ResetData(player)
			return "reset"
		end,
	})
end

return module