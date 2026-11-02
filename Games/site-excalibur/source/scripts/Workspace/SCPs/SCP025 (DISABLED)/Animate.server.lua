local animation = script:WaitForChild("Animation")
local npc = script.Parent:WaitForChild("Humanoid")
local model = npc:LoadAnimation(animation)
model:Play()