local humanoid = script.Parent:FindFirstChildOfClass("Humanoid")
local animator = humanoid:FindFirstChild("Animator")
local animation = script.Parent:FindFirstChild("Idle")

local track = animator:LoadAnimation(animation)
track.Looped = true
track.Priority = Enum.AnimationPriority.Action3
track:Play()