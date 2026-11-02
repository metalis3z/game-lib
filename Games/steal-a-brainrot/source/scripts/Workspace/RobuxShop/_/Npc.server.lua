local Controllers = game:GetService("ReplicatedStorage"):WaitForChild("Controllers")
local InterfaceController = require(Controllers.InterfaceController)
local Parent = script.Parent
local Animator = Parent.AnimationController.Animator
local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://108903798809923"
local LoadAnimation = Animator:LoadAnimation(Animation)
LoadAnimation:Play()
LoadAnimation.Looped = true
Parent.OpenInterface.Triggered:Connect(function()
	InterfaceController:Toggle("Shop")
end)