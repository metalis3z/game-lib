local plr = game.Players.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid:GetPropertyChangedSignal("Health"):Connect(function()
	script.Parent.ImageTransparency = humanoid.Health / 100
end)		