local MessagingService = game:GetService("MessagingService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Global = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Global")

return function (context, duration: number)
	duration = math.floor(math.clamp(duration, 1, 999))

	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "countdown", duration)
		end)
	end

	pcall(function()
		MessagingService:PublishAsync("GlobalCountdown", {duration = duration})
	end)
end