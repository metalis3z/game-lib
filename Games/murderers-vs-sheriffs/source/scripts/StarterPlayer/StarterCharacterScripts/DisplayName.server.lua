local Players = game:GetService("Players")
local character = script.Parent
local humanoid = character:FindFirstChildOfClass("Humanoid")
local player = Players:GetPlayerFromCharacter(character)
humanoid.DisplayName = player.DisplayName