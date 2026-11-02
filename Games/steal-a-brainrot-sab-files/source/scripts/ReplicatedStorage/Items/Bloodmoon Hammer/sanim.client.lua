local tool = script.Parent
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character
local humanoid

local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://80379996193457"

local animationTrack
local equipped = false

local sound = tool:WaitForChild("Slash")

tool.Equipped:Connect(function()
	character = player.Character or player.CharacterAdded:Wait()
	humanoid = character:WaitForChild("Humanoid")

	animationTrack = humanoid:LoadAnimation(animation)
	equipped = true
end)

tool.Unequipped:Connect(function()
	equipped = false
	if animationTrack then
		animationTrack:Stop()
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not equipped or gameProcessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then

		if animationTrack then
			if animationTrack.IsPlaying then
				animationTrack:Stop()
			end
			animationTrack:Play()
		end

		if sound then
			sound:Play()
		end
	end
end)
