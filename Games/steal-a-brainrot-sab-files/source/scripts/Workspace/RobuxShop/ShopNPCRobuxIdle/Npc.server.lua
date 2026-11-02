local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Controllers")
local u2 = require(v1.InterfaceController)
local v3 = script.Parent
local v4 = v3.AnimationController.Animator
local v5 = Instance.new("Animation")
v5.AnimationId = "rbxassetid://72166650067149"
local v6 = v4:LoadAnimation(v5)
v6:Play()
v6.Looped = true
v3.OpenInterface.Triggered:Connect(function()
	u2:Toggle("Shop")
end)