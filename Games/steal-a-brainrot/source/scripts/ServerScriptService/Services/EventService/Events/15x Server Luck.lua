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
	local GradientTag = "slowgreenred"
	for _, Player: Player in Players:GetPlayers() do
		NotificationService.Notify(Player, "Kaizou activated " .. string.format("<%s>%s</%s>", GradientTag, "15x Luck", GradientTag) ..  "!", 5, "Sounds.Sfx.Success")
		LuckService:SetLuck(15)

	end
end

function Luck.OnStop()
	LuckService:SetLuck(1)
end

return Luck