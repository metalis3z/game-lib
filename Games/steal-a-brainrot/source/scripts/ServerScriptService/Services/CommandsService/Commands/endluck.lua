local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local LuckService = require(ServerScriptService.Services.LuckService)

	Conch.register("endluck", {
		permissions = { Config.RequiredRole or "limited-commands" },

		arguments = function()
			return nil
		end,

		callback = function(speaker, args)
			if not args or args.Index == nil then
				if LuckService:GetEndTime() == 0 then
					return "Luck is not active"
				end

				LuckService:StartLuck(0, 0)
				return "luck ended"
			end

			local index = tonumber(args.Index)
			if not index then
				return false, "Invalid luck index"
			end

			if LuckService:GetEndTime() == 0 then
				return false, "Luck is not active"
			end

			if LuckService:GetCurrentLuckIndex() ~= index then
				return false, "This luck index is not active"
			end

			LuckService:StartLuck(0, 0)
			return "ended"
		end
	})
end

return module