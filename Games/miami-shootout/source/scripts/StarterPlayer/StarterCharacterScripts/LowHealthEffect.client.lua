local player = game.Players.LocalPlayer
local character = script.Parent
local humanoid = character:FindFirstChild("Humanoid")
local sound = player.PlayerGui:FindFirstChild("LowHealthSound")

while wait() do
	if humanoid.Health <= 45 then
		if sound.Playing == false then
			sound:Play()
		end
	else
		if sound.Playing == true then
			sound:Stop()
		end
	end
end