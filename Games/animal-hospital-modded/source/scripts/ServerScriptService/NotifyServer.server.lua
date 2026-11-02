local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Global = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Global")

MessagingService:SubscribeAsync("GlobalNotify", function(data)
	local msg = data.Data

	local message = msg.message
	local userid = msg.userid
	local name = msg.name
	--[[
	discord.gg/Tsw2b2EkSE is this only server that this admin abuse SHOULD be sold on.
	]]--
	for _, player in ipairs(Players:GetPlayers()) do
		local success, err = pcall(function()
			Global:FireClient(player, "globalNotify", message, userid, name)
		end)

		if not success then
			warn("[GlobalNotify] Failed to fire client:", err)
		end
	end
end)