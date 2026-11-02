local animation = script:WaitForChild("Animation")
local animController = script.Parent:WaitForChild("AnimationController")

local animator = animController:WaitForChild("Animator")

local track = animator:LoadAnimation(animation)
track:Play()