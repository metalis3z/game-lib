if not game:IsLoaded() then game.Loaded:Wait() end

task.wait(3)

local plr = game.Players.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local bloodOverlay = script.Parent

while true do
	wait(.1)
	bloodOverlay.ImageTransparency = humanoid.Health / 85
end