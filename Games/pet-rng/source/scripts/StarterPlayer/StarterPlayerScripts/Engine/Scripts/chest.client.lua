local player = game.Players.LocalPlayer

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local Modules = RSEngine:WaitForChild("Modules")
local ChestModule = require(Modules.ChestModule)

ChestModule.SetUp(player)