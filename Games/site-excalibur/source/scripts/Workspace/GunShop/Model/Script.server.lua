local animation = script:WaitForChild('Animation')
local humanoid = script.Parent:WaitForChild('Humanoid')
local Animate = humanoid:LoadAnimation(animation)
Animate:Play()