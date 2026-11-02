local module = function(Conch, Config)
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local LuckService = require(ServerScriptService.Services.LuckService)
	local NotificationService = require(ServerScriptService.Services.NotificationService)

	Conch.register("addluck", {
		permissions = { Config.RequiredRole or "admin" },

		arguments = function()
			return {
				kind = "argument",
				type = "ServerLuck",
				name = "Luck",
			}
		end,
		callback = function(luckIndex)
			local Index = tonumber(luckIndex)
			if not Index then
				return false, "Invalid luck index"
			end

			local EndTime = LuckService:GetEndTime()

			if EndTime ~= 0 then
				EndTime += 900
			else
				EndTime = workspace:GetServerTimeNow() + 900
			end

			LuckService:StartLuck(Index, EndTime)

			if Index == 1 then
				local text = 'GYK Admin activated <font color="#79DD2F">2x Luck</font>!'

				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(
						player,
						text,
						5,
						"Sounds.Sfx.Success"
					)
				end
			end

			if Index == 2 then
				local text = 'GYK Admin activated <font color="#F8DB14">4x Luck</font>!'

				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(
						player,
						text,
						5,
						"Sounds.Sfx.Success"
					)
				end
			end
			return "added"
		end
	})
end

return module