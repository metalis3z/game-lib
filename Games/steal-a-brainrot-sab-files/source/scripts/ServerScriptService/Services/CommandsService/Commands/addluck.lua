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
				local text = 'Sammy activated <font color="#79DD2F">2x Luck</font>!'
				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(player, text, 5, "Sounds.Sfx.Success")
				end

			elseif Index == 2 then
				local text = 'Sammy activated <font color="#F8DB14">4x Luck</font>!'
				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(player, text, 5, "Sounds.Sfx.Success")
				end

			elseif Index == 3 then
				local text = 'Sammy activated <font color="#E84AFF">6x Luck</font>!'
				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(player, text, 5, "Sounds.Sfx.Success")
				end
			
			elseif Index == 4 then
				local GradientTag = "zebra"
				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(player, "Sammy activated" .. string.format("<%s>%s</%s>", GradientTag, " 10x Luck", GradientTag) ..  "!", 5, "Sounds.Sfx.Success")
				end
			
			elseif Index == 5 then
				local GradientTag = "og"
				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(player, "Sammy activated" .. string.format("<%s>%s</%s>", GradientTag, " 12x Luck", GradientTag) ..  "!", 5, "Sounds.Sfx.Success")
				end
				
			elseif Index == 6 then
				local GradientTag = "slowgreenred"
				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(player, "Sammy activated" .. string.format("<%s>%s</%s>", GradientTag, " 15x Luck", GradientTag) ..  "!", 5, "Sounds.Sfx.Success")
				end
			end

			return "added"
		end,
	})
end

return module
