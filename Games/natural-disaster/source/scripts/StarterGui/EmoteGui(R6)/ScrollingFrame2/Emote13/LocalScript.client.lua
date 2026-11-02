local player = game.Players.LocalPlayer
local chr = player.Character
local playing = false
local hum = chr:WaitForChild("Humanoid")
local animation = script:FindFirstChild("Animation")
local btn = script.Parent
local lod = hum:LoadAnimation(animation)

btn.MouseButton1Click:Connect(function()
	if playing == false then
		playing = true
		lod:Play()
	else
		playing = false
		lod:Stop()
	end
end)