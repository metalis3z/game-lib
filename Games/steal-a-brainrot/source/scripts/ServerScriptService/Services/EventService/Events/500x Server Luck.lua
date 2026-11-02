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
	for _, Player: Player in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(
			Player,
			'<font color="#FFFDD0">500x Luck</font> has been activated!',
			5,
			"Sounds.Sfx.Success"
		)
	end

	LuckService:SetLuck(500)
end

function Luck.OnStop()
	LuckService:SetLuck(4)
end

return Luck