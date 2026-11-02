--!native

local Luck = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local NotificationService = require(ServerScriptService.Services.NotificationService)
local LuckService = require(ServerScriptService.Services.LuckService)



function Luck.OnStart()

	local gradientTag = "zebra"
	for _, Player: Player in Players:GetPlayers() do
		NotificationService.Notify(Player, "Sammy Activated " .. string.format("<%s>%s</%s>", gradientTag, "10x Luck!", gradientTag) ..  "!", 5, "Sounds.Sfx.Success")
		LuckService:SetLuck(10)

	end
end

function Luck.OnStop()
LuckService:SetLuck(4)
end

return Luck