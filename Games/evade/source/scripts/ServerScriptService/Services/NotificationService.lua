--!strict
local NotificationService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)

local NotifyRemote = Net:RemoteEvent("NotificationService/Notify")
local UpdateNotifyRemote = Net:RemoteEvent("NotificationService/UpdateNotify")
local CloseNotifyRemote = Net:RemoteEvent("NotificationService/CloseNotify")

function NotificationService.Error(Player: Player, Text: string)
	NotifyRemote:FireClient(Player, ("<font color=\"#FA0103\">%*</font>"):format(Text), 5, "Sounds.Sfx.Error")
end

function NotificationService.Success(Player: Player, Text: string)
	NotifyRemote:FireClient(Player, ("<font color=\"#92FF67\">%*</font>"):format(Text), 5, "Sounds.Sfx.Success")
end

function NotificationService.Notify(Player: Player, Text: string, Duration: number?, Sound: string?, _, Position: string?)
	NotifyRemote:FireClient(Player, Text, Duration or 5, Sound, _, Position)
end

function NotificationService.NotifyTop(Player: Player, Text: string, Duration: number?, Sound: string?)
	NotificationService.Notify(Player, Text, Duration or 5, Sound, nil, "Top")
end

function NotificationService.CreateUpdatableNotify(Player: Player, NotificationId: string, Text: string, Sound: string?, Position: string?)
	NotifyRemote:FireClient(Player, Text, nil, Sound, NotificationId, Position)
end

function NotificationService.UpdateNotify(Player: Player, NotificationId: string, NewText: string)
	UpdateNotifyRemote:FireClient(Player, NotificationId, NewText)
end

function NotificationService.CloseNotify(Player: Player, NotificationId: string, FadeTime: number?)
	CloseNotifyRemote:FireClient(Player, NotificationId, FadeTime or 1)
end

function NotificationService.Broadcast(Text: string, Duration: number?, Sound: string?)
	for _, Player in Players:GetPlayers() do
		NotificationService.Notify(Player, Text, Duration, Sound)
	end
end

function NotificationService.BroadcastTop(Text: string, Duration: number?, Sound: string?)
	for _, Player in Players:GetPlayers() do
		NotificationService.NotifyTop(Player, Text, Duration, Sound)
	end
end

function NotificationService.BroadcastUpdatable(NotificationId: string, Text: string, Sound: string?, Position: string?)
	for _, Player in Players:GetPlayers() do
		NotificationService.CreateUpdatableNotify(Player, NotificationId, Text, Sound, Position)
	end
end

function NotificationService.UpdateBroadcast(NotificationId: string, NewText: string)
	for _, Player in Players:GetPlayers() do
		NotificationService.UpdateNotify(Player, NotificationId, NewText)
	end
end

function NotificationService.CloseBroadcast(NotificationId: string, FadeTime: number?)
	for _, Player in Players:GetPlayers() do
		NotificationService.CloseNotify(Player, NotificationId, FadeTime)
	end
end

return NotificationService