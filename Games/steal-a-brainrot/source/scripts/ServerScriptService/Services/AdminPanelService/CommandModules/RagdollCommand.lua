local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local RagdollCommand = {}
RagdollCommand.__index = RagdollCommand

local activeRagdolls = {}

function RagdollCommand.new()
	return setmetatable({}, RagdollCommand)
end

function RagdollCommand:Execute(executor: Player, targetPlayer: Player)
	local character = targetPlayer.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if targetPlayer:GetAttribute("Ragdolled") or activeRagdolls[targetPlayer] then
		return
	end

	activeRagdolls[targetPlayer] = true
	targetPlayer:SetAttribute("Ragdolled", true)

	humanoid.PlatformStand = true
	Ragdoll.Ragdoll(character)

	task.delay(5, function()
		if not character.Parent then return end

		Ragdoll.Unragdoll(character)
		humanoid.PlatformStand = false

		targetPlayer:SetAttribute("Ragdolled", nil)
		activeRagdolls[targetPlayer] = nil
	end)
end

return RagdollCommand.new()