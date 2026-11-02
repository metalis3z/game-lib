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
			'Sammy activated <font color="#FF80FF">30x Luck</font>!',
			5,
			"Sounds.Sfx.Success"
		)
	end

	LuckService:SetLuck(35)
end

function Luck.OnStop()
	LuckService:SetLuck(4)
end

return Luck