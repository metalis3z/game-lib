local module = function(Conch, Config)
	Conch.register("rainbowannounce", {
		permissions = { Config.RequiredRole or "admin" },

		arguments = function()
			return {
				{ kind = "argument", type = "string", name = "Message", optional = false }
			}
		end,

		callback = function(message)
			-- Play sound
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://17208361335" -- Replace with your desired SoundId
			sound.Volume = 1
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local Net = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"))
			local Notify = Net:RemoteEvent("NotificationService/Notify")

			for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
				Notify:FireClient(player, message, 6, "rainbow", "Top")
			end

			return "? Gold announcement sent!"
		end
	})
end

return module
