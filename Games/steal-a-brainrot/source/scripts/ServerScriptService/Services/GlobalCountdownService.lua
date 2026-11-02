local GlobalCountdownService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)
local Notify = Net:RemoteEvent("NotificationService/Notify")

function GlobalCountdownService.NotifyAll(text, duration, sound, position, id, destroyFlag)
	for _, player in ipairs(Players:GetPlayers()) do
		Notify:FireClient(player, text, duration, sound, position, nil, id, destroyFlag)
	end
end

function GlobalCountdownService.NotifyPlayer(Player: Player, text, duration, sound, position, id, destroyFlag)
	Notify:FireClient(Player, text, duration, sound, position, nil, id, destroyFlag)
end

return GlobalCountdownService