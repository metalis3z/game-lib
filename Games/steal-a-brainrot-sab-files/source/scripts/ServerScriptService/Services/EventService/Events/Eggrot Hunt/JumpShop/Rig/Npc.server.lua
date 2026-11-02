local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://133736747097986"
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")
local animationTrack = animator:LoadAnimation(Animation)
animationTrack:Play()
animationTrack.Looped = true