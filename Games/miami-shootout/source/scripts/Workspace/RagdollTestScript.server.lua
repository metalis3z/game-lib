--[[
	This is a test file to demonstrate how ragdolls work. If you don't use
	this file, you need to manually apply the Ragdoll tag to humanoids that
	you want to ragdoll
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPack = game:GetService("StarterPack")
local StarterPlayer = game:GetService("StarterPlayer")

-- Enable this if you want to test ragdolls in zero - g
local ANTIGRAV_ENABLED = false
if ANTIGRAV_ENABLED then
	script.Gravity.Parent = StarterPlayer.StarterCharacterScripts
	workspace.Gravity = 0
end

local buildRagdoll = require(ReplicatedStorage:WaitForChild("buildRagdoll"))

-- Trying to clone something with Archivable=false will return nil for some reason
-- Helper function to enable Archivable, clone, reset Archivable to what it was before
-- and then return the clone
function safeClone(instance)
	local oldArchivable = instance.Archivable
	
	instance.Archivable = true
	local clone = instance:Clone()
	instance.Archivable = oldArchivable
	
	return clone
end

function characterAdded(player, character)
	player.CharacterAppearanceLoaded:wait()
	wait(0.1)
	
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	buildRagdoll(humanoid)
end

function characterRemoving(character)

end

function playerAdded(player)
	player.CharacterAdded:connect(function(character)
		characterAdded(player, character)
		local cHum 
		cHum = character.Humanoid.Died:Connect(function()
			cHum:Disconnect()
		end)
	end)
	
	player.CharacterRemoving:Connect(characterRemoving)
	
	if player.Character then
		characterAdded(player, player.Character)
	end
end

Players.PlayerAdded:connect(playerAdded)
-- Ugly hack because sometimes PlayerAdded doesn't fire in play solo
for _,player in pairs(Players:GetPlayers()) do
	playerAdded(player)
end
