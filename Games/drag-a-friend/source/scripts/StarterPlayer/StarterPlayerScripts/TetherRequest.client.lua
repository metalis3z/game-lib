local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local event = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("StartTether")
local player = Players.LocalPlayer

task.wait(3)
event:FireServer()
