-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local StarterPlayer = game:GetService("StarterPlayer")
local Players = game:GetService("Players")
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local CharacterController = require(Controllers.CharacterController)
local LocalPlayer = Players.LocalPlayer

return {
	GetCurrentJumpHeight = function(_)
		local CharacterJumpHeight = StarterPlayer.CharacterJumpHeight
		local v9, _, _ = CharacterController:GetCharacter()

		if not v9 then
			return 0
		end

		local Tool = v9:FindFirstChildOfClass("Tool")

		if Tool then
			local JumpModifier = Tool:GetAttribute("JumpModifier")

			if JumpModifier then
				CharacterJumpHeight *= JumpModifier
			end
		end

		if LocalPlayer:GetAttribute("Stealing") then
			CharacterJumpHeight *= 0.6
		end

		return (math.clamp(CharacterJumpHeight, 0, 1e999))
	end,
	GetCurrentWalkSpeed = function(_)
		local CharacterWalkSpeed = StarterPlayer.CharacterWalkSpeed
		local v16, _, _ = CharacterController:GetCharacter()

		if not v16 then
			return 0
		end

		local Tool = v16:FindFirstChildOfClass("Tool")

		if Tool then
			local SpeedModifier = Tool:GetAttribute("SpeedModifier")

			if SpeedModifier then
				CharacterWalkSpeed *= SpeedModifier
			end
		end

		if LocalPlayer:GetAttribute("Stealing") then
			CharacterWalkSpeed *= 0.6
		end

		return (math.clamp(CharacterWalkSpeed, 0, 1e999))
	end,
	Start = function(_)
	end
}
