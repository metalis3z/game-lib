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

	for _, Player: Player in Players:GetPlayers() do
		NotificationService.Notify(Player, "Sammy Activated <font color='#aa3cff'>6x Luck!</font>" .. "!", 5, "Sounds.Sfx.Success")
		LuckService:SetLuck(6)
	end
end

function Luck.OnStop()
	LuckService:SetLuck(4)

end

return Luck