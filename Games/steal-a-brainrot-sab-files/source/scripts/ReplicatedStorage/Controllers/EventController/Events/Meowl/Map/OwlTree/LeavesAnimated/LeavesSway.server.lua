



local v1 = script.Parent.AnimationController.LeavesSway
local v2 = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(v1)
v2.Looped = true
v2:Play()