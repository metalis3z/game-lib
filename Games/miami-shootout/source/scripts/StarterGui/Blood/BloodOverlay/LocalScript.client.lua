wait()
local plr = game.Players.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid")
local bloodOverlay = script.Parent

while true do
	wait()
	bloodOverlay.ImageTransparency = humanoid.Health / 100
end