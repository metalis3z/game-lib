local module = function(Conch, Config)
	Conch.register("servermessage", {
		permissions = { Config.RequiredRole or "admin" },

		arguments = function()
			return {
				{ kind = "argument", type = "string", name = "Message", optional = false }
			}
		end,

		callback = function(message)
			local Players = game:GetService("Players")
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local Packages = ReplicatedStorage:WaitForChild("Packages")
			local Net = require(Packages:WaitForChild("Net"))
			local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

			for _, player in ipairs(Players:GetPlayers()) do
				-- Send message
				NotificationEvent:FireClient(player, message, 5, nil, "Top")

				-- Play sound
				local sound = Instance.new("Sound")
				sound.SoundId = "rbxassetid://17208361335" -- Replace with your desired SoundId
				sound.Volume = 1
				sound.Parent = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")
				sound:Play()
				game:GetService("Debris"):AddItem(sound, 5)
			end

			return "? Server message sent with sound: " .. message
		end
	})
end

return module
