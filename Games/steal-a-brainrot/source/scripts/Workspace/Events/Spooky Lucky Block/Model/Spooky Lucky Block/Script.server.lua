local v1 = game:GetService("ReplicatedStorage")
local v2 = script.Parent.AnimationController.Animator:LoadAnimation(v1.Animations.Animals["Spooky Lucky Block"].Idle)
v2.Looped = true
v2:Play()