local anim = script.Parent:WaitForChild('Animation')
local hum = script.Parent:WaitForChild('Humanoid')
local medved = hum.Animator:LoadAnimation(anim)
medved:Play()