


local v1 = script.CarAnimationLoop
local v2 = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(v1)
v2.Looped = true
v2:Play()
v2:AdjustSpeed(0.33)