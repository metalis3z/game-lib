local Animation = script:WaitForChild("Animation")
local NPC = script.Parent:WaitForChild("NPC")
local Idle = NPC:LoadAnimation(Animation)

Idle:Play()

