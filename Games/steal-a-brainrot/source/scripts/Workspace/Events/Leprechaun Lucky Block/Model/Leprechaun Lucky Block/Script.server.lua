local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Animation = script.Parent.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Animations.Animals["Festive Lucky Block"].Idle)
Animation.Looped = true
Animation:Play()