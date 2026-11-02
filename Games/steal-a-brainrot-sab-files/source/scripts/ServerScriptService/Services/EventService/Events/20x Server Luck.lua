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
	local colorHex = "#ff80ff"

	for _, Player: Player in Players:GetPlayers() do
		local message = string.format("Sammy activated <font color=\"%s\">20x Luck</font>!", colorHex)

		NotificationService.Notify(Player, message, 5, "Sounds.Sfx.Success")
		LuckService:SetLuck(20)
	end
end

function Luck.OnStop()
	LuckService:SetLuck(4)
end

return Luck