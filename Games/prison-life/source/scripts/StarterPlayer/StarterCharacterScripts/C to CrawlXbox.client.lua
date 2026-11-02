

local uis = game:GetService("UserInputService")

repeat game:GetService("RunService").Stepped:Wait() until game.Players.LocalPlayer

local player = game.Players.LocalPlayer

AnimationId = "11275763829"

local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://"..AnimationId

local k = player.Character.Humanoid:LoadAnimation(Anim)
k:AdjustSpeed(10)

uis.InputBegan:Connect(function(input)

	if input.KeyCode == Enum.KeyCode.DPadDown then
		player.Character.Humanoid:UnequipTools()
		game.StarterGui:SetCoreGuiEnabled("Backpack", false);
		k:Play()
	end
end)


uis.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.DPadDown then
	
		game.StarterGui:SetCoreGuiEnabled("Backpack", true);
		k:Stop()
	end
end)