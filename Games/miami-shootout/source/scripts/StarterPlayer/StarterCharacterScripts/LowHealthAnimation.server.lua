local character = script.Parent
local humanoid = character:FindFirstChild("Humanoid")
local animation = game.ReplicatedStorage:FindFirstChild("LowHealthAnim")
local loadedAnimation = humanoid:LoadAnimation(animation)

while wait() do
	if humanoid.Health <= 40 then
		loadedAnimation:Play()
	else
		loadedAnimation:Stop()
	end
end