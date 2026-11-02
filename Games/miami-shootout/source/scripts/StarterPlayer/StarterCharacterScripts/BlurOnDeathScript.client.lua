local Hum = script.Parent:WaitForChild("Humanoid")
local Lighting = game:GetService("Lighting")
local Blur = Lighting:WaitForChild("Blur")
Blur.Size = 0

repeat wait() until Hum.Health == 0
for i = 1, 40 do
	wait(.05)
	Blur.Size = Blur.Size + 2
end
script:Destroy()