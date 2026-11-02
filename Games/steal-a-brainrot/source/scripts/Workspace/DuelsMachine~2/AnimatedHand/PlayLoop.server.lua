local SlapHandRotate = script.SlapHandRotate
local Animation = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(SlapHandRotate)

Animation.Looped = true
Animation:Play()
Animation:AdjustSpeed(0.5)