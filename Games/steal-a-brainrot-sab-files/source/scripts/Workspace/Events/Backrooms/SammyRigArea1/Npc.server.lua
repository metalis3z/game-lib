
local Animator = script.Parent.AnimationController.Animator
local Animation = Instance.new("Animation")

Animation.AnimationId = "rbxassetid://101599194747633"

local v3 = Animator:LoadAnimation(Animation)

v3:Play()
v3.Looped = true
