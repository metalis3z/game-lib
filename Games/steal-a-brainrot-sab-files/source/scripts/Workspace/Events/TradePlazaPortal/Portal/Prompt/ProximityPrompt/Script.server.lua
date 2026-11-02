local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local Notify = Net:RemoteEvent("NotificationService/Notify")

local PLACE_ID = 97887234862133
local prompt = script.Parent
local teleporting = {}

prompt.Triggered:Connect(function(player)
	if teleporting[player] then return end
	teleporting[player] = true

	for i = 3, 1, -1 do
		Notify:FireClient(player, "Vous etes teleporte dans " .. i .. " seconde" .. (i > 1 and "s" or ""), 1)
		task.wait(1)
	end

	Notify:FireClient(player, "Teleportation en cours...", 2)

	local success, err = pcall(function()
		TeleportService:Teleport(PLACE_ID, player)
	end)

	if not success then
		Notify:FireClient(player, "Teleportation echouee: " .. tostring(err), 3)
	end

	teleporting[player] = nil
end)