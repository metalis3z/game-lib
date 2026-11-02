local Fuse = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)

local NotificationService = require(ReplicatedStorage.Path.To.NotificationService)

function Fuse.OnStart()
	local fuseluck = require(script.Parent.Parent.Parent.FuseMachineService)

	fuseluck:StartLuck(4)

	NotificationService.BroadcastTop(
		"Santa's fuse Luck has been activated!", 
		7, 
		"Sounds.Sfx.Success"
	)
end

function Fuse.OnStop()

end

return Fuse