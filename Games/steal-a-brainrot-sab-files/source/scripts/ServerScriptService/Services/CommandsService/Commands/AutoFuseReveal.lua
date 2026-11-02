local module = function(Conch, Config)

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local MessagingService = game:GetService("MessagingService")
	local Players = game:GetService("Players")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local Net = require(ReplicatedStorage.Packages.Net)

	local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

	local AutoFuseActive = false

	-- 🔥 Skip fuse
	local function skipFuseForAllPlayers()
		if not AutoFuseActive then return end

		for _, player in ipairs(Players:GetPlayers()) do
			pcall(function()
				local Data = Synchronizer:Get(player)
				if not Data then return end

				local FuseMachine = Data:Get("FuseMachine")
				if not FuseMachine then return end
				if not FuseMachine.StartTime or FuseMachine.StartTime == 0 then return end

				Data:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())

				NotificationEvent:FireClient(
					player,
					"N0VA a skip ton <font color='#CE4D4C'>Fuse</font> ⚡",
					5,
					"Sounds.Sfx.Success"
				)
			end)
		end
	end

	-- ⏱️ Activation
	local function activateAutoFuse(duration)
		AutoFuseActive = true

		for _, player in ipairs(Players:GetPlayers()) do
			NotificationEvent:FireClient(
				player,
				"N0VA a activé l'Auto Fuse pendant "..duration.." secondes ⚡",
				6,
				"Sounds.Sfx.Success"
			)
		end

		task.delay(duration, function()
			AutoFuseActive = false
		end)
	end

	-- 🌐 Multi serveur
	MessagingService:SubscribeAsync("GlobalAutoFuse", function(message)
		local data = message.Data
		if not data then return end
		if data.FromServer == game.JobId then return end

		if data.Duration then
			activateAutoFuse(data.Duration)
		end
	end)

	-- 💬 COMMANDE (IMPORTANT: nom en minuscule comme ton système)
	Conch.register("autofusereveal", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				{
					name = "time",
					type = "number",
					required = true
				}
			}
		end,

		callback = function(context)
			local duration = tonumber(context.arguments.time) or 30

			activateAutoFuse(duration)

			pcall(function()
				MessagingService:PublishAsync("GlobalAutoFuse", {
					FromServer = game.JobId,
					Duration = duration
				})
			end)

			return "AutoFuseReveal activé pendant "..duration.."s"
		end,
	})

end

return module