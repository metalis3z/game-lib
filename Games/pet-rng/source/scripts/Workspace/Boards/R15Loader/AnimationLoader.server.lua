local humanoid = script.Parent.Humanoid

wait(1)
local animation = script.Parent.Animation:FindFirstChildOfClass("Animation")



local track = humanoid:LoadAnimation(animation)
track.Looped = true
track:Play()