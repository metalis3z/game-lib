local tool = script.Parent
local anim = tool.Animations:WaitForChild("use")
local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local loadanim = humanoid:LoadAnimation(anim)

tool.Activated:Connect(function()
	loadanim:Play()
	script.Parent.UseSound:Play()
	wait(0.25)
	script.Parent.UseSound:Play()
	
	game:GetService("Players").LocalPlayer:GetMouse().Target:FindFirstAncestorOfClass("Model"):Destroy()
end)