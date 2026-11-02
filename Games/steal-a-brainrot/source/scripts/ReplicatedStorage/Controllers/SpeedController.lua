local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local Players = game:GetService("Players")

local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local CharacterController = require(Controllers.CharacterController)

local LocalPlayer = Players.LocalPlayer

local SpeedController = {}

function SpeedController.GetCurrentJumpHeight()
	local JumpHeight = StarterPlayer.CharacterJumpHeight

	local Character = CharacterController:GetCharacter()
	if not Character then
		return 0
	end

	local Tool = Character:FindFirstChildOfClass("Tool")
	if Tool then
		local JumpModifier = Tool:GetAttribute("JumpModifier")
		if JumpModifier then
			JumpHeight *= JumpModifier
		end
	end

	if LocalPlayer:GetAttribute("Stealing") then
		JumpHeight *= 0.6
	end

	return math.clamp(JumpHeight, 0, math.huge)
end

function SpeedController.GetCurrentWalkSpeed()
	local WalkSpeed = StarterPlayer.CharacterWalkSpeed

	local Character = CharacterController:GetCharacter()
	if not Character then
		return 0
	end

	local Tool = Character:FindFirstChildOfClass("Tool")
	if Tool then
		local SpeedModifier = Tool:GetAttribute("SpeedModifier")
		if SpeedModifier then
			WalkSpeed *= SpeedModifier
		end
	end

	if LocalPlayer:GetAttribute("Stealing") then
		WalkSpeed *= 0.6
	end

	return math.clamp(WalkSpeed, 0, math.huge)
end

function SpeedController.Start()
end

return SpeedController