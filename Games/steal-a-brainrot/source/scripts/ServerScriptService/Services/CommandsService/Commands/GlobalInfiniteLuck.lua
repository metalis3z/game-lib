local module = function(Conch, Config)
	local MessagingService = game:GetService("MessagingService")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")
	local LuckService = require(ServerScriptService.Services.LuckService)
	local NotificationService = require(ServerScriptService.Services.NotificationService)

	local CHANNEL = "GlobalInfiniteLuck"

	pcall(function()
		if not _G._sub_GlobalInfiniteLuck then _G._sub_GlobalInfiniteLuck = true
		pcall(function()
		MessagingService:SubscribeAsync(CHANNEL, function(message)
			local data = message.Data
			if typeof(data) ~= "table" then return end
			if data.FromServer == game.JobId then return end

			local isEnabled = data.enabled
			if isEnabled == nil then isEnabled = true end
			
			if not isEnabled then
				-- Désactiver le luck
				LuckService:StartLuck(1, 0)
				
				local GradientTag = "rainbow"
				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(player,
						"GYK ADMIN deactivated" .. string.format("<%s>%s</%s>", GradientTag, " 100x LUCK!", GradientTag) .. "!",
						10, "Sounds.Sfx.Success")
				end
				return
			end
			
			local durationSeconds = data.duration
			local EndTime = LuckService:GetEndTime()
			if EndTime ~= 0 then
				EndTime += durationSeconds
			else
				EndTime = workspace:GetServerTimeNow() + durationSeconds
			end

			LuckService:StartLuck(100, EndTime)

			local GradientTag = "rainbow"
			for _, player in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(player,
					"GYK ADMIN activated" .. string.format("<%s>%s</%s>", GradientTag, " 100x LUCK!", GradientTag) .. "!",
					10, "Sounds.Sfx.Success")
			end
		end)
		end) end
	end)

	Conch.register("GlobalInfiniteLuck", {
		permissions = { Config.RequiredRole or "admin" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "boolean",
					name = "Enabled",
					optional = true,
				},
				{
					kind = "argument",
					type = "number",
					name = "Duration",
					optional = true,
				},
			}
		end,
		callback = function(enabled, duration)
			local isEnabled = enabled
			if isEnabled == nil then isEnabled = true end
			
			if not isEnabled then
				-- Désactiver le luck
				LuckService:StartLuck(1, 0)
				
				local GradientTag = "rainbow"
				for _, player in ipairs(Players:GetPlayers()) do
					NotificationService.Notify(player,
						"GYK ADMIN deactivated" .. string.format("<%s>%s</%s>", GradientTag, " 100x LUCK!", GradientTag) .. "!",
						10, "Sounds.Sfx.Success")
				end
				
				-- Publica globalmente
				pcall(function()
					MessagingService:PublishAsync(CHANNEL, {
						FromServer = game.JobId,
						enabled = false,
					})
				end)
				
				return "🍀 100x Luck global DESATIVADO!"
			end
			
			local durationSeconds = tonumber(duration) or 60
			local EndTime = LuckService:GetEndTime()
			if EndTime ~= 0 then
				EndTime += durationSeconds
			else
				EndTime = workspace:GetServerTimeNow() + durationSeconds
			end

			LuckService:StartLuck(100, EndTime)

			local GradientTag = "rainbow"
			for _, player in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(player,
					"GYK ADMIN activated" .. string.format("<%s>%s</%s>", GradientTag, " 100x LUCK!", GradientTag) .. "!",
					10, "Sounds.Sfx.Success")
			end

			-- Publica globalmente
			pcall(function()
				MessagingService:PublishAsync(CHANNEL, {
					FromServer = game.JobId,
					enabled = true,
					duration = durationSeconds,
				})
			end)

			return "🍀 100x Luck global ativado por " .. durationSeconds .. " segundos!"
		end,
	})
end

return module