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
			'Kaizou activated <font color="#A203EA">6x Luck</font>!',
			5,
			"Sounds.Sfx.Success"
		)
	end

	LuckService:SetLuck(6)
end

function Luck.OnStop()
	LuckService:SetLuck(1)
end

return Luck