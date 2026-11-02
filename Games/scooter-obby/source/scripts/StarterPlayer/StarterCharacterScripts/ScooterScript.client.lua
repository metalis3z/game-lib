-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- Constants
local localPlayer = Players.LocalPlayer
local Ignore = Workspace:WaitForChild("Ignore")
local modulesFolder = ReplicatedStorage:WaitForChild("Module")
local scooterModule = require(modulesFolder:WaitForChild("Scooter"))

-- Make the player's character archivable so I can modify it
localPlayer.Character.Archivable = true

-- Create a scooter for existing characters
for _, character in pairs(Ignore:GetChildren()) do
	if not character.Name:find("Scooter") then
		scooterModule.new(character)
	end
end

-- Create a scooter for new characters :)
Ignore.ChildAdded:Connect(function(character)
	if not character.Name:find("Scooter") then
		scooterModule.new(character)
	end
end)
