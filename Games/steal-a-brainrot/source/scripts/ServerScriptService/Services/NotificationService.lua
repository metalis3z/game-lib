local NotificationService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

local Notify = Net:RemoteEvent("NotificationService/Notify")

function NotificationService.Error(Player: Player, Text: string)
	Notify:FireClient(Player, ("<font color=\"#FA0103\">%*</font>"):format(Text), 5, "Sounds.Sfx.Error")
end

function NotificationService.Success(Player: Player, Text: string)
	Notify:FireClient(Player, ("<font color=\"#92FF67\">%*</font>"):format(Text), 5, "Sounds.Sfx.Success")
end

function NotificationService.Notify(...) 
	Notify:FireClient(...) 
end

return NotificationService