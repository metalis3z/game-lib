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

function playerAdded(player)
	player.CharacterAdded:connect(function(character)
		characterAdded(player, character)
		local cHum 
		cHum = character.Humanoid.Died:Connect(function()
			if character:FindFirstChild('RAGDOLLED') then return end
			for _, v in pairs(character:GetDescendants()) do 
				if v:IsA("Motor6D") and v.Parent.Name ~= 'Handle' then
					local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
					a0.CFrame = v.C0
					a1.CFrame = v.C1
					a0.Parent = v.Part0
					a1.Parent = v.Part1
					local b = Instance.new("BallSocketConstraint")
					b.Attachment0 = a0
					b.Attachment1 = a1
					b.Parent = v.Part0
					v.Enabled = false
				end
				if v.Name == "HumanoidRootPart" then
					v.CanCollide = false
				end
			end
			game.ReplicatedStorage.RagdollClient:FireClient(player,"ragdoll")
			local RAGDOLLED = Instance.new('BoolValue', character)
			RAGDOLLED.Name = 'RAGDOLLED'
			cHum:Disconnect()
		end)
	end)

	if player.Character then
		characterAdded(player, player.Character)
	end
end

Players.PlayerAdded:connect(playerAdded)
-- Ugly hack because sometimes PlayerAdded doesn't fire in play solo
for _,player in pairs(Players:GetPlayers()) do
	playerAdded(player)
end
