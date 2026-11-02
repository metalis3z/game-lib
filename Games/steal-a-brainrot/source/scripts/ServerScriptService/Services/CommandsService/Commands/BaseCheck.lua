local BaseCheckService = require(game.ServerScriptService.Services.BaseCheckService)

return function(Conch, Config)
	Conch.register("basecheck", {
		aliases = { "basecheck" },
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "@Joueur",
			}, {
				kind = "argument",
				type = "boolean",
				name = "Afficher",
				optional = true,
			}
		end,

		callback = function(targetName, show)
			local ctx = Conch.get_command_context()
			local player = ctx and ctx.executor and ctx.executor.player

			if not BaseCheckService:IsAllowedPlayer(player) then
				return false, "Accès réservé à @do_zynna et @badr_studio."
			end

			if not targetName or tostring(targetName) == "" then
				return false, "Utilise : basecheck @Pseudo true"
			end

			if show == false then
				return BaseCheckService:Clear(targetName)
			end

			return BaseCheckService:Show(targetName)
		end,
	})
end