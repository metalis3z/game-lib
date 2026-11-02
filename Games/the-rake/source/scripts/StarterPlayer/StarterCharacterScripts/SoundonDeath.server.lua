
repeat wait() until script.Parent:FindFirstChildOfClass("Humanoid")

local human = script.Parent:FindFirstChildOfClass("Humanoid")
local torso = script.Parent:WaitForChild("Torso")
script.BoneBreak.Parent = torso
script.Splatter.Parent = torso
local boneBreak = torso:FindFirstChild("BoneBreak")
local splatter = torso:FindFirstChild("Splatter")

human.Died:Connect(function()
	boneBreak:Play()
	splatter:Play()
end)