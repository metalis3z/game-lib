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
end

function Luck.OnStop()

end

return Luck